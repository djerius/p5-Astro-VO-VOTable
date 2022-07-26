#! perl

use Test2::V0;
use Test::Lib;

use XML::LibXML;

use My::Test::Util ':all';

subtest read_fields => sub {

    my $xml = XML::LibXML->load_xml( location => 'data/mesRot.binary.xml' );
    ( $xml ) = $xml->getElementsByTagName( $_ ) for 'VOTABLE', 'RESOURCE', 'TABLE';

    is(
       read_fields( $xml ),
        array {
            item object {
                call name      => 'bibcode';
                call datatype  => 'char';
                call arraysize => '*';
            };

            item object {
                call name => 'mespos';
                call datatype => 'short';
                call null   => -32768;
            };

            item object {
                call name     => 'nbmes';
                call datatype => 'short';
                call null     => -32768;
            };

            item object {
                call name     => 'oidref';
                call datatype => 'long';
                call null     => '-9223372036854775808';
            };

            item object {
                call name      => 'qual';
                call datatype  => 'char';
                call arraysize => 1;
            };

            item object {
                call name      => 'upvsini';
                call datatype  => 'char';
                call arraysize => 1;
            };

            item object {
                call name     => 'vsini';
                call datatype => 'float';
            };

            item object {
                call name     => 'vsini_err';
                call datatype => 'float';
            };

            item object {
                call name     => 'vsini_err_prec';
                call datatype => 'short';
                call null     => -32768;
            };

            item object {
                call name     => 'vsini_prec';
                call datatype => 'short';
                call null     => -32768;
            };
            end;
        } );


};


done_testing;
