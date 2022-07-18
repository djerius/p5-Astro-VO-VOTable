# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 8 };
use Astro::VO::VOTable::Element;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

#########################

# External modules
use English;
use XML::LibXML;

# Subroutine prototypes
sub test_new();
sub test_get();
sub test_set();
sub test_empty();
sub test_get_valid_attribute_names();
sub test_get_valid_child_element_names();
sub test_AUTOLOAD();

#########################

# Test.
ok(test_new, 1);
ok(test_get, 1);
ok(test_set, 1);
ok(test_empty, 1);
ok(test_get_valid_attribute_names, 1);
ok(test_get_valid_child_element_names, 1);
ok(test_AUTOLOAD, 1);

#########################

sub test_new()
{

    # Local variables

    # Reference to test element object.
    my($element);

    #--------------------------------------------------------------------------

    # Test the plain-vanilla constructor.
    Astro::VO::VOTable::Element->new or return(0);

    # Try creating from a XML::LibXML::Element object.
    Astro::VO::VOTable::Element->new(XML::LibXML::Element->new('Element'))
	or return(0);

    # Make sure the constructor fails when a bad reference is passed.
    not eval { Astro::VO::VOTable::Element->new(\0) } or return(0);
    not eval { Astro::VO::VOTable::Element->new([]) } or return(0);

    #--------------------------------------------------------------------------

    # Return success.
    return(1);

}

sub test_get()
{

    # Local variables

    # XML::LibXML parser object to create objects.
    my($parser);

    # Test XML string.
    my($xml);

    # XML::LibXML::Document object for test XML.
    my($document);

    # XML::LibXML::Element object for test description.
    my($description);

    #--------------------------------------------------------------------------

    # Create the parser.
    $parser = XML::LibXML->new or return(0);

    # Parse the XML into a document object.
    $xml = '<VOTABLE><DESCRIPTION>This is a test.</DESCRIPTION></VOTABLE>';
    $document = $parser->parse_string($xml) or return(0);

    # Drill down to the DESCRIPTION element.
    $description = ($document->documentElement->
  		    getChildrenByTagName('DESCRIPTION'))[0] or return(0);

    # Manually bless the XML::LibXML::Element object to a
    # Astro::VO::VOTable::Element object.
    bless $description => 'Astro::VO::VOTable::Element';

    # Retrieve the content of the DESCRIPTION element.
    $description->get eq 'This is a test.' or return(0);

    # Make sure an empty element returns an empty string.
    $description = Astro::VO::VOTable::Element->new or return(0);
    $description->get eq '' or return(0);

    #--------------------------------------------------------------------------

    # Make sure character entity references are properly handled.

    # Ampersand ('&' => '&amp').
    $xml = '<VOTABLE><DESCRIPTION>&amp;</DESCRIPTION></VOTABLE>';
    $document = $parser->parse_string($xml) or return(0);
    $description = ($document->documentElement->
    		    getChildrenByTagName('DESCRIPTION'))[0] or return(0);
    bless $description => 'Astro::VO::VOTable::Element';
    $description->get eq '&' or return(0);

    # Less-than ('<' => '&lt').
    $xml = '<VOTABLE><DESCRIPTION>&lt;</DESCRIPTION></VOTABLE>';
    $document = $parser->parse_string($xml) or return(0);
    $description = ($document->documentElement->
    		    getChildrenByTagName('DESCRIPTION'))[0] or return(0);
    bless $description => 'Astro::VO::VOTable::Element';
    $description->get eq '<' or return(0);

    # Greater-than ('>' => '&gt').
    $xml = '<VOTABLE><DESCRIPTION>&gt;</DESCRIPTION></VOTABLE>';
    $document = $parser->parse_string($xml) or return(0);
    $description = ($document->documentElement->
    		    getChildrenByTagName('DESCRIPTION'))[0] or return(0);
    bless $description => 'Astro::VO::VOTable::Element';
    $description->get eq '>' or return(0);

    # Quote ('"' => '&quot').
    $xml = '<VOTABLE><DESCRIPTION>&quot;</DESCRIPTION></VOTABLE>';
    $document = $parser->parse_string($xml) or return(0);
    $description = ($document->documentElement->
      		    getChildrenByTagName('DESCRIPTION'))[0] or return(0);
    bless $description => 'Astro::VO::VOTable::Element';
    $description->get eq '"' or return(0);

    # Apostrophe ("'" => '&apos').
    $xml = '<VOTABLE><DESCRIPTION>&apos;</DESCRIPTION></VOTABLE>';
    $document = $parser->parse_string($xml) or return(0);
    $description = ($document->documentElement->
      		    getChildrenByTagName('DESCRIPTION'))[0] or return(0);
    bless $description => 'Astro::VO::VOTable::Element';
    $description->get eq "'" or return(0);

    #--------------------------------------------------------------------------

    # Test that CDATA sections are handled properly.
    $xml =<<_EOS_
<VOTABLE>
  <DESCRIPTION><![CDATA[&<>\"\']]></DESCRIPTION>
</VOTABLE>
_EOS_
    ;
    $document = $parser->parse_string($xml) or return(0);
    $description = ($document->documentElement->
      		    getChildrenByTagName('DESCRIPTION'))[0] or return(0);
    bless $description => 'Astro::VO::VOTable::Element';
    $description->get eq '&<>"\'' or return(0);

    #--------------------------------------------------------------------------

    # All tests passed.
    return(1);

}

sub test_set()
{

    # Local variables

    # XML::LibXML parser object to create objects.
    my($parser);

    # Test XML string.
    my($xml);

    # XML::LibXML::Document object for test XML.
    my($document);

    # XML::LibXML::Element object for test description.
    my($description);

    #--------------------------------------------------------------------------

    # Create the parser.
    $parser = XML::LibXML->new or return(0);

    # Parse the XML into a document object.
    $xml = '<VOTABLE><DESCRIPTION/></VOTABLE>';
    $document = $parser->parse_string($xml) or return(0);

    # Drill down to the DESCRIPTION element.
    $description = ($document->documentElement->
		    getChildrenByTagName('DESCRIPTION'))[0] or return(0);

    # Manually bless the XML::DOM::Element object to a
    # Astro::VO::VOTable::Element object.
    bless $description => 'Astro::VO::VOTable::Element';

    # Set then retrieve the content of the DESCRIPTION element.
    $description->set('This is a test.') or return(0);
    $description->get eq 'This is a test.' or return(0);

    #--------------------------------------------------------------------------

    # Make sure character entity references are properly handled.

    # Ampersand ('&' => '&amp').
    $description->set('&');
    $description->get eq '&' or return(0);
    $description->set('&amp;');
    $description->get eq '&amp;' or return(0);

    # Less-than ('<' => '&lt').
    $description->set('<');
    $description->get eq '<' or return(0);
    $description->set('&lt;');
    $description->get eq '&lt;' or return(0);

    # Greater-than ('>' => '&gt').
    $description->set('>');
    $description->get eq '>' or return(0);
    $description->set('&gt;');
    $description->get eq '&gt;' or return(0);

    # Quote ('"' => '&quot').
    $description->set('"');
    $description->get eq '"' or return(0);
    $description->set('&quot;');
    $description->get eq '&quot;' or return(0);

    # Apostrophe (''' => '&apos').
    $description->set("'");
    $description->get eq "'" or return(0);
    $description->set('&apos;');
    $description->get eq '&apos;' or return(0);

    #--------------------------------------------------------------------------

    # All tests passed.
    return(1);

}

sub test_empty()
{
    my($parser);
    my($xml) = '<VOTABLE><DESCRIPTION>This is a test.<![CDATA[So is this.]]></DESCRIPTION></VOTABLE>';
    my($document);
    my($description);

    #--------------------------------------------------------------------------

    # Create the parser.
    $parser = XML::LibXML->new or return(0);

    # Parse the XML into a document object.
    $document = $parser->parse_string($xml) or return(0);

    # Drill down to the DESCRIPTION element.
    $description = ($document->documentElement->
		    getChildrenByTagName('DESCRIPTION'))[0] or return(0);

    # Manually bless the XML::DOM::Element object to a
    # Astro::VO::VOTable::Element object.
    bless $description => 'Astro::VO::VOTable::Element';

    # Empty then check the content of the DESCRIPTION element.
    $description->empty;
    $description->get eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_valid_attribute_names()
{
    my($element);
    my(@attribute_names);

    # Create a new Element object.
    $element = Astro::VO::VOTable::Element->new or return(0);
    use vars @Astro::VO::VOTable::Element::valid_attribute_names;
    @Astro::VO::VOTable::Element::valid_attribute_names = ();

    # Make sure it has no attributes.
    not $element->get_valid_attribute_names or return(0);

    # Now add some and check them.
    @Astro::VO::VOTable::Element::valid_attribute_names = qw(ID);
    @attribute_names = $element->get_valid_attribute_names;
    @attribute_names == 1 or return(0);
    $attribute_names[0] eq 'ID' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_valid_child_element_names()
{
    my($element);
    my(@names);

    # Create a new Element object.
    $element = Astro::VO::VOTable::Element->new or return(0);
    use vars @Astro::VO::VOTable::Element::valid_child_element_names;
    @Astro::VO::VOTable::Element::valid_child_element_names = ();

    # Make sure it has no child elements.
    not $element->get_valid_child_element_names or return(0);

    # Now add some and check them.
    @Astro::VO::VOTable::Element::valid_child_element_names = qw(VOTABLE);
    @names = $element->get_valid_child_element_names;
    @names == 1 or return(0);
    $names[0] eq 'VOTABLE' or return(0);

    # All tests passed.
    return(1);

}

sub test_AUTOLOAD()
{
    my($parser);
    my($xml);
    my($document);
    my($votable);
    my($resource);
    my($resource2);
    my($resource3);

    #--------------------------------------------------------------------------

    # Create the parser.
    $parser = XML::LibXML->new or return(0);

    # Parse the XML into a document object.
    $xml = '<VOTABLE><RESOURCE ID="0"/></VOTABLE>';
    $document = $parser->parse_string($xml) or return(0);

    # Drill down to the VOTABLE element.
    $votable = $document->documentElement or return(0);
    bless $votable => 'Astro::VO::VOTable::Element';

    #--------------------------------------------------------------------------

    # Test attribute accessors.

    # Create a RESOURCE element for testing.
    $resource = Astro::VO::VOTable::Element->new or return(0);
    $resource->setNodeName('RESOURCE');
    $resource->setAttribute('ID', '1');

    # Test the attribute 'set' and 'get' mechanisms.
    use vars @Astro::VO::VOTable::Element::valid_attribute_names;
    @Astro::VO::VOTable::Element::valid_attribute_names = qw(ID);
    $resource->set_ID('another test');
    $resource->get_ID eq 'another test' or return(0);
    $resource->set_ID('yet another test');
    $resource->get_ID eq 'yet another test' or return(0);

    # Test the attribute 'remove' mech`xanism.
    $resource->remove_ID;
    not defined($resource->get_ID) or return(0);

    #--------------------------------------------------------------------------

    # Test element accessors.

    use vars @Astro::VO::VOTable::Element::valid_child_element_names;
    @Astro::VO::VOTable::Element::valid_child_element_names = qw(RESOURCE);

    # Test the element 'get' mechanism.
    $resource = $votable->get_RESOURCE(0) or return(0);
    ref($resource) eq 'Astro::VO::VOTable::RESOURCE' or return(0);

    # Test the element 'set' mechanism.
    $resource2 = Astro::VO::VOTable::Element->new or return(0);
    $resource2->setNodeName('RESOURCE');
    $resource2->setAttribute('ID', '2');
    $votable->set_RESOURCE($resource2);
    $resource = $votable->get_RESOURCE(0) or return(0);
    bless $resource => 'Astro::VO::VOTable::Element';
    $resource->isSameNode($resource2) or return(0);

    # Test the element 'append' mechanism.
    $resource3 = Astro::VO::VOTable::Element->new or return(0);
    $resource3->setNodeName('RESOURCE');
    $resource3->setAttribute('ID', '3');
    $votable->append_RESOURCE($resource3);
    $resource = $votable->get_RESOURCE(1);
    bless $resource => 'Astro::VO::VOTable::Element';
    $resource->isSameNode($resource3) or return(0);

    # Test the element 'remove' mechanism.
    $votable->remove_RESOURCE;
    not $votable->get_RESOURCE or return(0);

    #--------------------------------------------------------------------------

    # All tests passed.
    return(1);

}
