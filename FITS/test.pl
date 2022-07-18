# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 4 };
use Astro::VO::VOTable::FITS;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

#########################

# External modules

# Subroutine prototypes
sub test_new();
sub test_get_STREAM();
sub test_set_STREAM();

#########################

# Test.
ok(test_new, 1);
ok(test_get_STREAM, 1);
ok(test_set_STREAM, 1);

#########################

sub test_new()
{

    # Test the plain-vanilla constructor.
    Astro::VO::VOTable::FITS->new or return(0);

    # Try creating from a XML::LibXML::Element object.
    Astro::VO::VOTable::FITS->new(XML::LibXML::Element->new('FITS')) or return(0);

    # Make sure the constructor fails when a bad reference is passed
    # in.
    not eval { Astro::VO::VOTable::FITS->new(XML::LibXML::Element->new('JUNK')) }
      or return(0);
    not eval { Astro::VO::VOTable::FITS->new(\0) } or return(0);
    not eval { Astro::VO::VOTable::FITS->new([]) } or return(0);

    #--------------------------------------------------------------------------

    # Return success.
    return(1);

}

sub test_get_STREAM()
{
    my($parser);
    my($xml);
    my($document);
    my($votable);
    my($resource);
    my($table);
    my($data);
    my($fits);
    my($stream);

    #--------------------------------------------------------------------------

    # Create the parser.
    $parser = XML::LibXML->new or return(0);

    # Parse the XML.
    $xml = '<VOTABLE><RESOURCE><TABLE><DATA><FITS><STREAM/></FITS></DATA></TABLE></RESOURCE></VOTABLE>';
    $document = $parser->parse_string($xml) or return(0);

    # Fetch the VOTABLE element.
    $votable = $document->documentElement or return(0);

    # Fetch the RESOURCE element.
    $resource = $votable->getChildrenByTagName('RESOURCE')->get_node(1)
	or return(0);

    # Fetch the TABLE element.
    $table = $resource->getChildrenByTagName('TABLE')->get_node(1)
	or return(0);

    # Fetch the DATA element.
    $data = $table->getChildrenByTagName('DATA')->get_node(1) or return(0);

    # Fetch the FITS element.
    $fits = $data->getChildrenByTagName('FITS')->get_node(1)
	or return(0);
    $fits = Astro::VO::VOTable::FITS->new($fits) or return(0);

    # Fetch the STREAM element.
    $stream = $fits->get_STREAM(0) or return(0);
    $stream->isa('Astro::VO::VOTable::STREAM') or return(0);

    # All tests succeeded.
    return(1);

}

sub test_set_STREAM()
{
    my($parser);
    my($xml);
    my($document);
    my($votable);
    my($resource);
    my($table);
    my($data);
    my($fits);
    my($stream);

    #--------------------------------------------------------------------------

    # Create the parser.
    $parser = XML::LibXML->new or return(0);

    # Parse the XML.
    $xml = '<VOTABLE><RESOURCE><TABLE><DATA><FITS/></DATA></TABLE></RESOURCE></VOTABLE>';
    $document = $parser->parse_string($xml) or return(0);

    # Fetch the VOTABLE element.
    $votable = $document->documentElement or return(0);

    # Fetch the RESOURCE element.
    $resource = $votable->getChildrenByTagName('RESOURCE')->get_node(1)
	or return(0);

    # Fetch the TABLE element.
    $table = $resource->getChildrenByTagName('TABLE')->get_node(1)
	or return(0);

    # Fetch the DATA element.
    $data = $table->getChildrenByTagName('DATA')->get_node(1) or return(0);

    # Fetch the FITS element.
    $fits = $data->getChildrenByTagName('FITS')->get_node(1)
	or return(0);
    $fits = Astro::VO::VOTable::FITS->new($fits) or return(0);

    # Create the STREAM element.
    $stream = XML::LibXML::Element->new('STREAM') or return(0);
    $fits->set_STREAM($stream);

    # Fetch the STREAM element.
    $stream->isSameNode($fits->get_STREAM(0)) or return(0);

    # All tests succeeded.
    return(1);

}
