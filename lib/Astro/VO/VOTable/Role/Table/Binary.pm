package Astro::VO::VOTable::Role::Table::Binary;

# ABSTRACT: methods for accessing data in a binary table

use Moo;
use Astro::VO::VOTable::Exception;
use Astro::VO::VOTable::Utils;

=attr row_id

Internal tracking of last row_id ead, so that subsequent reads are
optimized.

=cut

has row_id => (
    is       => 'ro',
    init_arg => undef,
);

=attr offset

Internal: current byte offset into the data stream.

=cut

has offset => (
    is       => 'rwp',
    init_arg => undef,
    default  => 0,
);

=attr pack_format

The Perl L<pack> compatible format which will be used to read a row

=cut

has pack_format => (
    is       => 'lazy',
    init_arg => undef,
);

=attr is_variable_record

True if the record has a variable length

=cut

has is_variable_record => (
    is      => 'lazy',
    builder => sub {
        my $self = shift;
        self->pack_format =~ m{/};
    },
);

sub _build_pack_format {
    my $self = shift;
    Astro::VO::VOTable::Utils::pack_format( $self->fields );
}

sub read_row {
    my ( $self, $row_id ) = @_;

    my @row;

    # if $row_id is defined, and not the next one, go to that row
    if ( defined $row_id && $row_id != $self->row_id || $self->row_id + 1 ) {

    }
    else {
        my $format = "x[${ \$self->offset }]" . $self->pack_format;
        my @row    = unpack( $format, $self->data );
        my $length = pop @row;
        # last value returned is the length in bytes that was processed. Don't
        # pass it back to the caller.
        $self->_set_offset( $self->offset + pop @row );
    }

    return \@row;
}
