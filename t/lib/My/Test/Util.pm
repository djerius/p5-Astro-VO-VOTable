package My::Test::Util;

use strict;
use warnings;

use List::Util qw( first );
use XML::LibXML ':libxml';
use Hash::Wrap;

use Class::Struct Field => {
    name      => '$',
    datatype  => '$',
    arraysize => '$',
    null      => '$',
    ptype     => '$',
};

use Exporter 'import';

use Astro::VO::VOTable::Util '%VOFieldTYPE';

our %EXPORT_TAGS = ( all => [qw( read_fields read_binary_data )] );
our @EXPORT_OK   = map { @$_ } values %EXPORT_TAGS;

=sub read_fields

  \@fields = read_fields( $xml );

Assumes that the XML element contains FIELD elements and returns
objects with methods mirroring the FIELD element attributes

=cut

sub read_fields {
    my $xml = shift;

    my @fields;

    for my $field ( $xml->getChildrenByTagName( 'FIELD' ) ) {

        my %attr;
        for my $attr ( grep { $_->nodeType == XML_ATTRIBUTE_NODE } $field->attributes ) {
            $attr{ $attr->nodeName } = $attr->value;
        }

        my ( $values ) = $field->getChildrenByTagName( 'VALUES' );

        if ( defined $values ) {
            my $null
              = first { $_->nodeType == XML_ATTRIBUTE_NODE && $_->nodeName eq 'null' } $values->attributes;
            $attr{null} = $null->value if defined $null;
        }

        $attr{ptype} = $VOFieldTYPE{ $attr{datatype} }->ptype;
        push @fields, Field->new( %attr );
    }

    return \@fields;
}

=sub read_binary_data

  ( \@fields, binary ) = read_binary_data( $xml_file );

Returns the base64 decoded  binary data from the first table in a VOTable XML file, e.g.

  VOTABLE { RESOURCE { TABLE { DATA { BINARY { STREAM { data } } } } } } 

See L</read_fields> for the format of C<$fields>

=cut

sub read_binary_data {

    my $file = shift;

    my $root = my $xml = XML::LibXML->load_xml( location => $file );
    ( $xml ) = $xml->getElementsByTagName( $_ ) for 'VOTABLE', 'RESOURCE', 'TABLE';
    my $fields = read_fields( $xml );

    ( $xml ) = $xml->getElementsByTagName( $_ ) for 'DATA', 'BINARY', 'STREAM';

    return ( $fields, MIME::Base64::decode_base64( $xml->textContent ) );
}

1;
