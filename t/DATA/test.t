# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 12 };
use Astro::VO::VOTable::DATA;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

#########################

# External modules

# Subroutine prototypes
sub test_new();
sub test_get_TABLEDATA();
sub test_set_TABLEDATA();
sub test_get_BINARY();
sub test_set_BINARY();
sub test_get_FITS();
sub test_set_FITS();
sub test_get_array();
sub test_get_row();
sub test_get_cell();
sub test_get_num_rows();

#########################

# Test.
ok(test_new, 1);
ok(test_get_TABLEDATA, 1);
ok(test_set_TABLEDATA, 1);
ok(test_get_BINARY, 1);
ok(test_set_BINARY, 1);
ok(test_get_FITS, 1);
ok(test_set_FITS, 1);
ok(test_get_array, 1);
ok(test_get_row, 1);
ok(test_get_cell, 1);
ok(test_get_num_rows, 1);

#########################

sub test_new()
{

    # Test the plain-vanilla constructor.
    Astro::VO::VOTable::DATA->new or return(0);

    # Try creating from a XML::LibXML::Element object.
    Astro::VO::VOTable::DATA->new(XML::LibXML::Element->new('DATA')) or return(0);

    # Make sure the constructor fails when a bad reference is passed
    # in.
    not eval { Astro::VO::VOTable::DATA->new(XML::LibXML::Element->new('JUNK')) }
      or return(0);
    not eval { Astro::VO::VOTable::DATA->new(\0) } or return(0);
    not eval { Astro::VO::VOTable::DATA->new([]) } or return(0);

    #--------------------------------------------------------------------------

    # Return success.
    return(1);

}

sub test_get_TABLEDATA()
{
    my($data);
    my($tabledata);

    $data = Astro::VO::VOTable::DATA->new or return(0);
    $tabledata = Astro::VO::VOTable::TABLEDATA->new or return(0);
    $data->appendChild($tabledata);
    $tabledata->isSameNode($data->get_TABLEDATA(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_TABLEDATA()
{
    my($data);
    my($tabledata);

    $data = Astro::VO::VOTable::DATA->new or return(0);
    $tabledata = Astro::VO::VOTable::TABLEDATA->new or return(0);
    $data->set_TABLEDATA($tabledata);
    $tabledata->isSameNode($data->get_TABLEDATA(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_BINARY()
{
    my($data);
    my($binary);

    $data = Astro::VO::VOTable::DATA->new or return(0);
    $binary = Astro::VO::VOTable::BINARY->new or return(0);
    $data->appendChild($binary);
    $binary->isSameNode($data->get_BINARY(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_BINARY()
{
    my($data);
    my($binary);

    $data = Astro::VO::VOTable::DATA->new or return(0);
    $binary = Astro::VO::VOTable::BINARY->new or return(0);
    $data->set_BINARY($binary);
    $binary->isSameNode($data->get_BINARY(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_FITS()
{
    my($data);
    my($fits);

    $data = Astro::VO::VOTable::DATA->new or return(0);
    $fits = Astro::VO::VOTable::FITS->new or return(0);
    $data->appendChild($fits);
    $fits->isSameNode($data->get_FITS(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_FITS()
{
    my($data);
    my($fits);

    $data = Astro::VO::VOTable::DATA->new or return(0);
    $fits = Astro::VO::VOTable::FITS->new or return(0);
    $data->set_FITS($fits);
    $fits->isSameNode($data->get_FITS(0)) or return(0);

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
    my($data);
    my($array);

    # Create the parser.
    $parser = XML::LibXML->new() or return(0);

    # Parse the XML into a document object.
    $document = $parser->parse_string($xml) or return(0);

    # Drill down to the DATA element.
    $votable = $document->documentElement or return(0);
    $data = ($votable->getElementsByTagName('DATA'))[0] or return(0);

    # Create a Astro::VO::VOTable::DATA object.
    bless $data => 'Astro::VO::VOTable::DATA';

    # Fetch the table contents as an array.
    $array = $data->get_array or return(0);
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
    my($data);
    my(@values);

    # Create the parser.
    $parser = XML::LibXML->new() or return(0);

    # Parse the XML into a document object.
    $document = $parser->parse_string($xml) or return(0);

    # Drill down to the DATA element.
    $votable = $document->documentElement or return(0);
    $data = ($votable->getElementsByTagName('DATA'))[0] or return(0);

    # Create a Astro::VO::VOTable::DATA object.
    bless $data => 'Astro::VO::VOTable::DATA';

    # Retrieve the contents of the TR elements as arrays and verify
    # the contents.
    @values = $data->get_row(0) or return(0);
    $values[0] eq '3.14159' or return(0);
    $values[1] eq '2.718282' or return(0);
    @values = $data->get_row(1) or return(0);
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
    my($data);
    my(@values);

    # Create the parser.
    $parser = XML::LibXML->new() or return(0);

    # Parse the XML into a document object.
    $document = $parser->parse_string($xml) or return(0);

    # Drill down to the DATA element.
    $votable = $document->documentElement or return(0);
    $data = ($votable->getElementsByTagName('DATA'))[0] or return(0);

    # Create a Astro::VO::VOTable::DATA object.
    bless $data => 'Astro::VO::VOTable::DATA';

    # Retrieve the contents of the TR elements as arrays and verify
    # the contents.
    $data->get_cell(0, 0) eq '3.14159' or return(0);
    $data->get_cell(0, 1) eq '2.718282' or return(0);
    $data->get_cell(1, 0) eq '2.22' or return(0);
    $data->get_cell(1, 1) eq '4.44' or return(0);

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
    my($data);

    # Create the parser.
    $parser = XML::LibXML->new() or return(0);

    # Parse the XML into a document object.
    $document = $parser->parse_string($xml) or return(0);

    # Drill down to the DATA element.
    $votable = $document->documentElement or return(0);
    $data = ($votable->getElementsByTagName('DATA'))[0] or return(0);

    # Create a Astro::VO::VOTable::DATA object.
    bless $data => 'Astro::VO::VOTable::DATA';

    # Retrieve and verify the row count.
    $data->get_num_rows == 2 or return(0);

    # All tests passed.
    return(1);

}
