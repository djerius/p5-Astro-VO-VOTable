#! perl

use autodie;

use Test2::V0;
use Test::Lib;

use List::Util qw( first );
use Astro::VO::VOTable::Util::BinaryCodec;
use File::Slurper;
use MIME::Base64;
use Text::CSV 'csv';

use My::Test::Util qw( read_fields read_binary_data );


my %csv_check_map = (
    Astro::VO::VOTable::Util::BinaryCodec::PerlTYPE_integer => {
        csv   => Text::CSV::IV,
        check => \&number
    },
    Astro::VO::VOTable::Util::BinaryCodec::PerlTYPE_float => {
        csv   => Text::CSV::NV,
        check => sub { within( $_[0], 1e-4 ) }
    },
    Astro::VO::VOTable::Util::BinaryCodec::PerlTYPE_string => {
        csv   => Text::CSV::PV,
        check => \&string
    },
    Astro::VO::VOTable::Util::BinaryCodec::PerlTYPE_boolean => {
        csv   => Text::CSV::PV,
        check => \&number
    },
);

my ( $fields, $binary ) = read_binary_data( 't/data/mesRot.binary.xml' );
my $codec = Astro::VO::VOTable::Util::BinaryCodec->new( fields => $fields );


# open CSV fiducial file and set the input type (number, float, string )
# based upon the datatype provided by the input XML file.
my $csv = Text::CSV->new( { empty_is_undef => 1 } )
  or die $@;
open( my $fh, '<', 't/data/mesRot.csv' );
my ( @types, %check );
for my $name ( $csv->header( $fh ) ) {
    my $field = first { $_->name eq $name } @$fields
      or die( "unable to match CSV field: $name" );
    my $map = $csv_check_map{ $field->ptype };
    push @types, $map->{csv};
    $check{$name} = $map->{check};
}

$csv->types( \@types );

my @got;
my @exp;
my $offset = 0;
my $length = length( $binary );
my @names  = map { $_->name } @$fields;
while ( $offset < $length ) {
    ( $offset, my $array ) = $codec->unpack( $offset, $binary );
    my %results;
    @results{@names} = @$array;
    push @got, \%results;

    my $exp = $csv->getline_hr( $fh );
    defined $exp->{$_} and $exp->{$_} = $check{$_}->( $exp->{$_} ) for keys %$exp;

    push @exp, $exp;
}

is( \@got, \@exp );

done_testing;
