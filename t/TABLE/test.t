# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 22 };
use Astro::VO::VOTable::TABLE;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

#########################

# External modules

# Subroutine prototypes
sub test_new();
sub test_get_ID();
sub test_set_ID();
sub test_get_name();
sub test_set_name();
sub test_get_ref();
sub test_set_ref();
sub test_get_DESCRIPTION();
sub test_set_DESCRIPTION();
sub test_get_FIELD();
sub test_set_FIELD();
sub test_get_LINK();
sub test_set_LINK();
sub test_get_DATA();
sub test_set_DATA();
sub test_get_array();
sub test_get_row();
sub test_get_cell();
sub test_get_num_rows();
sub test_get_field_position_by_name();
sub test_get_field_position_by_ucd();

#########################

# Test.
ok(test_new, 1);
ok(test_get_ID, 1);
ok(test_set_ID, 1);
ok(test_get_name, 1);
ok(test_set_name, 1);
ok(test_get_ref, 1);
ok(test_set_ref, 1);
ok(test_get_DESCRIPTION, 1);
ok(test_set_DESCRIPTION, 1);
ok(test_get_FIELD, 1);
ok(test_set_FIELD, 1);
ok(test_get_LINK, 1);
ok(test_set_LINK, 1);
ok(test_get_DATA, 1);
ok(test_set_DATA, 1);
ok(test_get_array, 1);
ok(test_get_row, 1);
ok(test_get_cell, 1);
ok(test_get_num_rows, 1);
ok(test_get_field_position_by_name, 1);
ok(test_get_field_position_by_ucd, 1);

#########################

sub test_new()
{

    # Test the plain-vanilla constructor.
    Astro::VO::VOTable::TABLE->new or return(0);

    # Try creating from a XML::LibXML::Element object.
    Astro::VO::VOTable::TABLE->new(XML::LibXML::Element->new('TABLE')) or return(0);

    # Make sure the constructor fails when a bad reference is passed
    # in.
    not eval { Astro::VO::VOTable::TABLE->new(XML::LibXML::Element->new('JUNK')) }
      or return(0);
    not eval { Astro::VO::VOTable::TABLE->new(\0) } or return(0);
    not eval { Astro::VO::VOTable::TABLE->new([]) } or return(0);

    #--------------------------------------------------------------------------

    # Return success.
    return(1);

}

sub test_get_ID()
{

    my($table);

    # Read ID from a new TABLE.
    $table = Astro::VO::VOTable::TABLE->new or return(0);
    $table->setAttribute('ID', 'test');
    $table->get_ID eq 'test' or return(0);

    # Read ID from a empty TABLE.
    $table->removeAttribute('ID');
    not defined($table->get_ID) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_ID()
{

    my($table);

    # Set then read ID from a new TABLE.
    $table = Astro::VO::VOTable::TABLE->new or return(0);
    $table->set_ID('test');
    $table->get_ID eq 'test' or return(0);

    # Read ID from a empty TABLE.
    $table->set_ID('');
    $table->get_ID eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_name()
{

    my($table);

    # Read name from a new TABLE.
    $table = Astro::VO::VOTable::TABLE->new or return(0);
    $table->setAttribute('name', 'test');
    $table->get_name eq 'test' or return(0);

    # Read name from a empty TABLE.
    $table->removeAttribute('name');
    not defined($table->get_name) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_name()
{

    my($table);

    # Set then read name from a new TABLE.
    $table = Astro::VO::VOTable::TABLE->new or return(0);
    $table->set_name('test');
    $table->get_name eq 'test' or return(0);

    # Read name from a empty TABLE.
    $table->set_name('');
    $table->get_name eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_ref()
{

    my($table);

    # Read ref from a new TABLE.
    $table = Astro::VO::VOTable::TABLE->new or return(0);
    $table->setAttribute('ref', 'test');
    $table->get_ref eq 'test' or return(0);

    # Read ref from a empty TABLE.
    $table->removeAttribute('ref');
    not defined($table->get_ref) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_ref()
{

    my($table);

    # Set then read ref from a new TABLE.
    $table = Astro::VO::VOTable::TABLE->new or return(0);
    $table->set_ref('test');
    $table->get_ref eq 'test' or return(0);

    # Read ref from a empty TABLE.
    $table->set_ref('');
    $table->get_ref eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_DESCRIPTION()
{
    my($table);
    my($description);

    $table = Astro::VO::VOTable::TABLE->new or return(0);
    $description = Astro::VO::VOTable::DESCRIPTION->new or return(0);
    $table->appendChild($description);
    $description->isSameNode($table->get_DESCRIPTION(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_DESCRIPTION()
{
    my($table);
    my($description);

    $table = Astro::VO::VOTable::TABLE->new or return(0);
    $description = Astro::VO::VOTable::DESCRIPTION->new or return(0);
    $table->set_DESCRIPTION($description);
    $description->isSameNode($table->get_DESCRIPTION(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_FIELD()
{
    my($table);
    my($field);

    $table = Astro::VO::VOTable::TABLE->new or return(0);
    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $table->appendChild($field);
    $field->isSameNode($table->get_FIELD(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_FIELD()
{
    my($table);
    my($field);

    $table = Astro::VO::VOTable::TABLE->new or return(0);
    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $table->set_FIELD($field);
    $field->isSameNode($table->get_FIELD(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_LINK()
{
    my($table);
    my($link);

    $table = Astro::VO::VOTable::TABLE->new or return(0);
    $link = Astro::VO::VOTable::LINK->new or return(0);
    $table->appendChild($link);
    $link->isSameNode($table->get_LINK(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_LINK()
{
    my($table);
    my($link);

    $table = Astro::VO::VOTable::TABLE->new or return(0);
    $link = Astro::VO::VOTable::LINK->new or return(0);
    $table->set_LINK($link);
    $link->isSameNode($table->get_LINK(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_DATA()
{
    my($table);
    my($data);

    $table = Astro::VO::VOTable::TABLE->new or return(0);
    $data = Astro::VO::VOTable::DATA->new or return(0);
    $table->appendChild($data);
    $data->isSameNode($table->get_DATA(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_DATA()
{
    my($table);
    my($data);

    $table = Astro::VO::VOTable::TABLE->new or return(0);
    $data = Astro::VO::VOTable::DATA->new or return(0);
    $table->set_DATA($data);
    $data->isSameNode($table->get_DATA(0)) or return(0);

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
    my($table);
    my($array);

    # Create the parser.
    $parser = new XML::LibXML or return(0);

    # Parse the XML into a document object.
    $document = $parser->parse_string($xml) or return(0);

    # Drill down to the TABLE element.
    $votable = $document->documentElement or return(0);
    $table = ($votable->getElementsByTagName('TABLE'))[0] or return(0);

    # Create a Astro::VO::VOTable::TABLE object.
    bless $table => 'Astro::VO::VOTable::TABLE';

    # Fetch the table contents as an array.
    $array = $table->get_array or return(0);
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
    my($table);
    my(@values);

    # Create the parser.
    $parser = new XML::LibXML or return(0);

    # Parse the XML into a document object.
    $document = $parser->parse_string($xml) or return(0);

    # Drill down to the TABLE element.
    $votable = $document->getDocumentElement or return(0);
    $table = ($votable->getElementsByTagName('TABLE'))[0] or return(0);

    # Create a Astro::VO::VOTable::TABLE object.
    bless $table => 'Astro::VO::VOTable::TABLE';

    # Retrieve the contents of the TR elements as arrays and verify
    # the contents.
    @values = $table->get_row(0) or return(0);
    $values[0] eq '3.14159' or return(0);
    $values[1] eq '2.718282' or return(0);
    @values = $table->get_row(1) or return(0);
    $values[0] eq '2.22' or return(0);
    $values[1] eq '4.44' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_cell()
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
    my($table);
    my(@values);

    # Create the parser.
    $parser = new XML::LibXML or return(0);

    # Parse the XML into a document object.
    $document = $parser->parse_string($xml) or return(0);

    # Drill down to the TABLE element.
    $votable = $document->getDocumentElement or return(0);
    $table = ($votable->getElementsByTagName('TABLE'))[0] or return(0);

    # Create a Astro::VO::VOTable::TABLE object.
    bless $table => 'Astro::VO::VOTable::TABLE';

    # Retrieve the contents of the TR elements as arrays and verify
    # the contents.
    $table->get_cell(0, 0) eq '3.14159' or return(0);
    $table->get_cell(0, 1) eq '2.718282' or return(0);
    $table->get_cell(1, 0) eq '2.22' or return(0);
    $table->get_cell(1, 1) eq '4.44' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_field_position_by_name()
{
    my($parser);
    my($xml) = <<_EOS_
<VOTABLE>
<RESOURCE>
<TABLE>
<FIELD name="field_x" ucd="POS_EQ_RA_MAIN"/>
<FIELD name="field_y" ucd="POS_EQ_DEC_MAIN"/>
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
    my($table);
    my(@values);

    # Create the parser.
    $parser = new XML::LibXML or return(0);

    # Parse the XML into a document object.
    $document = $parser->parse_string($xml) or return(0);

    # Drill down to the TABLE element.
    $votable = $document->getDocumentElement or return(0);
    $table = ($votable->getElementsByTagName('TABLE'))[0] or return(0);

    # Create a Astro::VO::VOTable::TABLE object.
    bless $table => 'Astro::VO::VOTable::TABLE';

    # Find the FIELD positions and verify them.
    $table->get_field_position_by_name('field_x') == 0 or return(0);
    $table->get_field_position_by_name('field_y') == 1 or return(0);

    # All tests passed.
    return(1);

}

sub test_get_field_position_by_ucd()
{
    my($parser);
    my($xml) = <<_EOS_
<VOTABLE>
<RESOURCE>
<TABLE>
<FIELD name="field_x" ucd="POS_EQ_RA_MAIN"/>
<FIELD name="field_y" ucd="POS_EQ_DEC_MAIN"/>
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
    my($table);
    my(@values);

    # Create the parser.
    $parser = new XML::LibXML or return(0);

    # Parse the XML into a document object.
    $document = $parser->parse_string($xml) or return(0);

    # Drill down to the TABLE element.
    $votable = $document->getDocumentElement or return(0);
    $table = ($votable->getElementsByTagName('TABLE'))[0] or return(0);

    # Create a Astro::VO::VOTable::TABLE object.
    bless $table => 'Astro::VO::VOTable::TABLE';

    # Find the FIELD positions and verify them.
    $table->get_field_position_by_ucd('POS_EQ_RA_MAIN') == 0 or return(0);
    $table->get_field_position_by_ucd('POS_EQ_DEC_MAIN') == 1 or return(0);

    # All tests passed.
    return(1);

}

sub test_get_num_rows()
{
    my($parser);
    my($xml) = <<_EOS_
<VOTABLE>
<RESOURCE>
<TABLE>
<FIELD name="field_x" ucd="POS_EQ_RA_MAIN"/>
<FIELD name="field_y" ucd="POS_EQ_DEC_MAIN"/>
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
    my($table);

    # Create the parser.
    $parser = new XML::LibXML or return(0);

    # Parse the XML into a document object.
    $document = $parser->parse_string($xml) or return(0);

    # Drill down to the TABLE element.
    $votable = $document->getDocumentElement or return(0);
    $table = ($votable->getElementsByTagName('TABLE'))[0] or return(0);

    # Create a Astro::VO::VOTable::TABLE object.
    bless $table => 'Astro::VO::VOTable::TABLE';

    # Find and verify the row count.
    $table->get_num_rows == 2 or return(0);

    # All tests passed.
    return(1);

}
