package Astro::VO::VOTable::Util::BinaryCodec;

use strict;
use warnings;

our $VERSION = '1.1';

use Astro::VO::VOTable::Util ':all';
use Astro::VO::VOTable::Exception ':all';

use Moo;

has pack_format => (
    is        => 'rwp',
    init_args => undef,
);

has unpack_format => (
    is        => 'rwp',
    init_args => undef,
);

sub BUILD {
    my ( $self, $args ) = @_;

    defined $args->{fields}
      or parameter_missing->throw( "missing 'fields' parameter" );

    $self->_set_unpack_format( _build_unpack_format( $args->{fields} ) );
    # $self->_set_pack_format( _build_pack_format( $args->{fields} ) );

}


use Class::Struct PackFormat => [
    template        => '$',  # the Perl pack() format for this field
    nelem           => '$',
    is_array        => '$',
    is_consolidated => '$',  # true if an array is read in but results in a single value (e.g. a string)
    null            => '$',
    ptype           => '$',
];

our %PackFormat = (

    # ASCII 'T', 't', '1', 'F', 'f', '0', ' ', '?'
    # or \x00
    ( +VOFieldTYPE_boolean ) => {
        template => 'a',
        nelem    => 1,
    },
    # bits. should this be kept as is to use vec()?
    ( +VOFieldTYPE_bit ) => {
        template => 'B',
        nelem    => -1,
    },

    ( +VOFieldTYPE_unsignedByte ) => {
        template => 'C',
        nelem    => 1,
    },

    # zero padded ASCII bytes,
    ( +VOFieldTYPE_char ) => {
        template        => 'Z',
        nelem           => 1,
        is_array        => 0,     # never return an array
        is_consolidated => 1,     # multiple input elements are consolidated into one output
        null            => '',    # an empty string is treated as NULL
    },

    # big endian unsighned 16-bit integer
    ( +VOFieldTYPE_unicodeChar ) => {
        template => 'S>',
        nelem    => 1,
    },

    # big endian signed 16-bit integer
    ( +VOFieldTYPE_short ) => {
        template => 's>',
        nelem    => 1,
    },

    # big endian signed 32-bit integer
    ( +VOFieldTYPE_int ) => {
        template => 'l>',
        nelem    => 1,
    },

    # big endian signed 64-bit integer
    ( +VOFieldTYPE_long ) => {
        template => 'q>',
        nelem    => 1,
    },

    # big endian single precision 32-bit float
    ( +VOFieldTYPE_float ) => {
        template => 'f>',
        nelem    => 1,
        null     => 'NaN',    # treat NaN as NULL
    },

    # big endian double precision 64-bit float
    ( +VOFieldTYPE_double ) => {
        template => 'F>',
        nelem    => 1,
        null     => 'NaN',    # treat NaN as NULL
    },

    # big endian single precision 32-bit float
    ( +VOFieldTYPE_floatComplex ) => {
        template => '(f>)2',
        nelem    => 2,
        is_array => 1,         # always returned as an array
        null     => 'NaN',     # treat NaN as NULL
    },

    # big endian double precision 64-bit float
    ( +VOFieldTYPE_doubleComplex ) => {
        template => '(F>)2',
        nelem    => 2,
        is_array => 1,         # always returned as an array
        null     => 'NaN',
    },
);

$PackFormat{$_} = PackFormat->new(
    is_array => 0,
    %{ $PackFormat{$_} },
    ptype => ( $VOFieldTYPE{$_} // die "no entry for $_" )->ptype,
) for keys %PackFormat;


=isub _build_unpack_format

  [ $template, \@field_fmt ]  = build_unpack_format ( \@FIELDS );

Return a L<pack> compatible format string which will unpack a single
row from an input I<Binary> formatted table.  The input parameter is a
list of the table's fields, as L<Astro::VO::VOTable::FIELD> objects.

=cut

sub _build_unpack_format {

    my ( $field_spec ) = @_;

    # the row length (in octets) is required to advance to the next row.
    # a row may contain multiple variable length fields, so it is in general not possible
    # to a priori know the length of a row.
    # use the '.!' pack template directive to return the byte offset into the string at the
    # end of the processed record.

    my @field_fmt;
    for my $field ( @$field_spec ) {
        my $pack = $PackFormat{ $field->datatype } // parameter_value_illegal->throw(
            "FIELD ${ \$field->name } has an unknown datatype: ${ \$field->datatype }" );

        my %format = (
            nelem           => $pack->nelem,
            template        => $pack->template,
            is_variable     => 0,
            is_array        => $pack->is_array,
            is_consolidated => $pack->is_consolidated,
            null            => $field->null // $pack->null,
            ptype           => $pack->ptype,
        );

        if ( defined $field->arraysize ) {
            $format{is_array} //= 1;
            if ( $field->arraysize eq '*' ) {
                $format{template}    = 'L> X[L>] L>/ ' . $pack->template;
                $format{is_variable} = 1;
            }
            else {
                $format{template} = sprintf( "(%s)[%s]", $pack->template, $field->arraysize );
                $format{nelem} *= $field->arraysize;
            }
        }

        push @field_fmt, \%format;
    }

    my $template = join ' ', map { $_->{template} } @field_fmt;

    return [ $template, \@field_fmt ];
}

sub unpack {
    my $self   = shift;
    my $offset = shift // 0;

    my $format  = join ' ', "x[$offset]", $self->unpack_format->[0], '.!';
    my @results = unpack( $format, $_[0] );
    $offset = pop @results;
    return $offset, $self->distribute_unpacked( \@results );
}

sub distribute_unpacked {
    my ( $self, $unpacked ) = @_;

    my $fields = $self->unpack_format->[1];

    my @row;
    my $begin = 0;
    for my $field ( @{$fields} ) {

        # skip over count to get to first datum
        my $nelem
          = $field->{is_variable}
          ? $unpacked->[$begin] * $field->{nelem}
          : $field->{nelem};

        $begin++                 if $field->{is_variable};
        $nelem = $field->{nelem} if $field->{is_consolidated};

        my $end = $begin + $nelem - 1;

        if ( defined $field->{null} ) {
            $_ = undef for grep { $_ eq $field->{null} } @{$unpacked}[ $begin .. $end ];
        }

        if ( $field->{is_array} ) {
            push @row, [ @{$unpacked}[ $begin .. $end ] ];
        }
        else {
            push @row, @{$unpacked}[ $begin .. $end ];
        }

        $begin = $end + 1;
    }

    \@row;
}

1;
