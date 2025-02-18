# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 8 };
use Astro::VO::VOTable::TABLEDATA;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

#########################

# External modules
use XML::LibXML;

# Subroutine prototypes
sub test_new();
sub test_get_TR();
sub test_set_TR();
sub test_get_array();
sub test_get_row();
sub test_get_cell();
sub test_get_num_rows();

#########################

# Test.
ok(test_new, 1);
ok(test_get_TR, 1);
ok(test_set_TR, 1);
ok(test_get_array, 1);
ok(test_get_row, 1);
ok(test_get_cell, 1);
ok(test_get_num_rows, 1);

#########################

sub test_new()
{

    # Test the plain-vanilla constructor.
    Astro::VO::VOTable::TABLEDATA->new or return(0);

    # Try creating from a XML::LibXML::Element object.
    Astro::VO::VOTable::TABLEDATA->new(XML::LibXML::Element->new('TABLEDATA'))
        or return(0);

    # Make sure the constructor fails when a bad reference is passed
    # in.
    not eval { Astro::VO::VOTable::TABLEDATA->new(XML::LibXML::Element->new('JUNK')) }
      or return(0);
    not eval { Astro::VO::VOTable::TABLEDATA->new(\0) } or return(0);
    not eval { Astro::VO::VOTable::TABLEDATA->new([]) } or return(0);

    #--------------------------------------------------------------------------

    # Return success.
    return(1);

}

sub test_get_TR()
{
    my($tabledata);
    my($tr);

    $tabledata = Astro::VO::VOTable::TABLEDATA->new or return(0);
    $tr = Astro::VO::VOTable::TR->new or return(0);
    $tabledata->appendChild($tr);
    $tr->isSameNode($tabledata->get_TR(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_TR()
{
    my($tabledata);
    my($tr);

    $tabledata = Astro::VO::VOTable::TABLEDATA->new or return(0);
    $tr = Astro::VO::VOTable::TR->new or return(0);
    $tabledata->set_TR($tr);
    $tr->isSameNode($tabledata->get_TR(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_array()
{
    my($parser);
    my($xml) = <<_EOS_
<VOTABLE>
<RESOURCE>
<TABLE>
<DATA>
<TABLEDATA>
<TR>
<TD>3.14159</TD><TD>2.718282</TD>
</TR>
<TR>
<TD>2.22</TD><TD>4.44</TD>
</TR>
</TABLEDATA>
</DATA>
</TABLE>
</RESOURCE>
</VOTABLE>
_EOS_
;
    my($document);
    my($votable);
    my($tabledata);
    my($array);

    # Create the parser.
    $parser = new XML::LibXML or return(0);

    # Parse the XML into a document object.
    $document = $parser->parse_string($xml) or return(0);

    # Drill down to the TABLEDATA element.
    $votable = $document->documentElement or return(0);
    $tabledata = ($votable->getElementsByTagName('TABLEDATA'))[0] or return(0);

    # Create a Astro::VO::VOTable::TABLEDATA object.
    bless $tabledata => 'Astro::VO::VOTable::TABLEDATA';

    # Fetch the table contents as an array.
    $array = $tabledata->get_array or return(0);
    $array->[0][0] eq '3.14159' or return(0);
    $array->[0][1] eq '2.718282' or return(0);
    $array->[1][0] eq '2.22' or return(0);
    $array->[1][1] eq '4.44' or return(0);

    # Return normally.
    return(1);

}

sub test_get_row()
{
    my($parser);
    my($xml) = <<_EOS_
<VOTABLE>
<RESOURCE>
<TABLE>
<DATA>
<TABLEDATA>
<TR>
<TD>3.14159</TD><TD>2.718282</TD>
</TR>
<TR>
<TD>2.22</TD><TD>4.44</TD>
</TR>
</TABLEDATA>
</DATA>
</TABLE>
</RESOURCE>
</VOTABLE>
_EOS_
;
    my($document);
    my($votable);
    my($tabledata);
    my(@values);

    # Create the parser.
    $parser = new XML::LibXML or return(0);

    # Parse the XML into a document object.
    $document = $parser->parse_string($xml) or return(0);

    # Drill down to the TABLEDATA element.
    $votable = $document->documentElement or return(0);
    $tabledata = ($votable->getElementsByTagName('TABLEDATA'))[0] or return(0);

    # Create a Astro::VO::VOTable::TABLEDATA object.
    bless $tabledata => 'Astro::VO::VOTable::TABLEDATA';

    # Retrieve the contents of the TR elements as arrays and verify
    # the contents.
    @values = $tabledata->get_row(0) or return(0);
    $values[0] eq '3.14159' or return(0);
    $values[1] eq '2.718282' or return(0);
    @values = $tabledata->get_row(1) or return(0);
    $values[0] eq '2.22' or return(0);
    $values[1] eq '4.44' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_cell()
{
    return(1);
}

sub test_get_num_rows()
{
    my($parser);
    my($xml) = <<_EOS_
<VOTABLE>
<RESOURCE>
<TABLE>
<DATA>
<TABLEDATA>
<TR>
<TD>3.14159</TD><TD>2.718282</TD>
</TR>
<TR>
<TD>2.22</TD><TD>4.44</TD>
</TR>
</TABLEDATA>
</DATA>
</TABLE>
</RESOURCE>
</VOTABLE>
_EOS_
;
    my($document);
    my($votable);
    my($tabledata);

    # Create the parser.
    $parser = new XML::LibXML or return(0);

    # Parse the XML into a document object.
    $document = $parser->parse_string($xml) or return(0);

    # Drill down to the TABLEDATA element.
    $votable = $document->documentElement or return(0);
    $tabledata = ($votable->getElementsByTagName('TABLEDATA'))[0] or return(0);

    # Create a Astro::VO::VOTable::TABLEDATA object.
    bless $tabledata => 'Astro::VO::VOTable::TABLEDATA';

    # Retrieve and verify the row count.
    $tabledata->get_num_rows == 2 or return(0);

    # All tests passed.
    return(1);

}
