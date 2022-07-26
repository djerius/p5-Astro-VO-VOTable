package Astro::VO::VOTable::Util;

use v5.10;

use strict;
use warnings;

our $VERSION = '1.1';

use List::Util qw( uniqstr );
use Astro::VO::VOTable::Exception ':all';

use Exporter 'import';

use Class::Struct VOFieldType => [
    name  => '$',
    ptype => '$',
];

our %VOFieldTypeNames;
our %PerlTYPES;

BEGIN {
    #<<< no tidy
    %VOFieldTypeNames = map {; "VOFieldTYPE_$_" => $_ }
      qw( boolean
          bit
          unsignedByte
          short
          int
          long
          char
          unicodeChar
          float
          double
          floatComplex
          doubleComplex
       );

    %PerlTYPES = map {; "PerlTYPE_$_" => $_ }
      qw( boolean integer float string );

    #>>> no tidy
}

use constant \%VOFieldTypeNames;
use constant \%PerlTYPES;

use constant PerlTYPES    => keys %PerlTYPES;
use constant VOFieldTYPES => keys %VOFieldTypeNames;

our %VOFieldTYPE;

BEGIN {
    %VOFieldTYPE = (

        # ASCII 'T', 't', '1', 'F', 'f', '0', ' ', '?'
        # or \x00
        +( VOFieldTYPE_boolean ) => {
            ptype => PerlTYPE_boolean,
        },
        # bits. should this be kept as is to use vec()?
        +( VOFieldTYPE_bit ) => {
            ptype => PerlTYPE_string,
        },

        +( VOFieldTYPE_unsignedByte ) => {
            ptype => PerlTYPE_integer,
        },

        # zero padded ASCII bytes,
        +( VOFieldTYPE_char ) => {
            ptype => PerlTYPE_string,
        },

        # big endian unsighned 16-bit integer
        +( VOFieldTYPE_unicodeChar ) => {
            ptype => PerlTYPE_string,
        },

        # big endian signed 16-bit integer
        +( VOFieldTYPE_short ) => {
            ptype => PerlTYPE_integer,
        },

        # big endian signed 32-bit integer
        +( VOFieldTYPE_int ) => {
            ptype => PerlTYPE_integer,
        },

        # big endian signed 64-bit integer
        +( VOFieldTYPE_long ) => {
            ptype => PerlTYPE_integer,
        },

        # big endian single precision 32-bit float
        +( VOFieldTYPE_float ) => {
            ptype => PerlTYPE_float,
        },

        # big endian double precision 64-bit float
        +( VOFieldTYPE_double ) => {
            ptype => PerlTYPE_float,
        },

        # big endian single precision 32-bit float
        +( VOFieldTYPE_floatComplex ) => {
            ptype => PerlTYPE_float,
        },

        # big endian double precision 64-bit float
        +( VOFieldTYPE_doubleComplex ) => {
            ptype => PerlTYPE_float,

        },
    );

    $VOFieldTYPE{$_} = VOFieldType->new( name => $_,
                                         %{ $VOFieldTYPE{$_} }
                                         ) for keys %VOFieldTYPE;
}


our %EXPORT_TAGS = (
    VOFieldTYPES => [ VOFieldTYPES, 'VOFieldTYPES', '%VOFieldTYPE' ],
    PerlTYPES    => [ PerlTYPES,    'PerlTYPES' ],
);
$EXPORT_TAGS{all} = [ uniqstr map { @$_ } values %EXPORT_TAGS ];
our @EXPORT_OK = @{ $EXPORT_TAGS{all} };



1;
