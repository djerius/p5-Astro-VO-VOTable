# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 28 };
use Astro::VO::VOTable::PARAM;
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
sub test_get_unit();
sub test_set_unit();
sub test_get_datatype();
sub test_set_datatype();
sub test_get_precision();
sub test_set_precision();
sub test_get_width();
sub test_set_width();
sub test_get_ref();
sub test_set_ref();
sub test_get_name();
sub test_set_name();
sub test_get_ucd();
sub test_set_ucd();
sub test_get_value();
sub test_set_value();
sub test_get_arraysize();
sub test_set_arraysize();
sub test_get_DESCRIPTION();
sub test_set_DESCRIPTION();
sub test_get_VALUES();
sub test_set_VALUES();
sub test_get_LINK();
sub test_set_LINK();

#########################

# Test.
ok(test_new, 1);
ok(test_get_ID, 1);
ok(test_set_ID, 1);
ok(test_get_unit, 1);
ok(test_set_unit, 1);
ok(test_get_datatype, 1);
ok(test_set_datatype, 1);
ok(test_get_precision, 1);
ok(test_set_precision, 1);
ok(test_get_width, 1);
ok(test_set_width, 1);
ok(test_get_ref, 1);
ok(test_set_ref, 1);
ok(test_get_name, 1);
ok(test_set_name, 1);
ok(test_get_ucd, 1);
ok(test_set_ucd, 1);
ok(test_get_value, 1);
ok(test_set_value, 1);
ok(test_get_arraysize, 1);
ok(test_set_arraysize, 1);
ok(test_get_DESCRIPTION, 1);
ok(test_set_DESCRIPTION, 1);
ok(test_get_VALUES, 1);
ok(test_set_VALUES, 1);
ok(test_get_LINK, 1);
ok(test_set_LINK, 1);

#########################

sub test_new()
{

    # Test the plain-vanilla constructor.
    Astro::VO::VOTable::PARAM->new or return(0);

    # Try creating from a XML::LibXML::Element object.
    Astro::VO::VOTable::PARAM->new(XML::LibXML::Element->new('PARAM')) or return(0);

    # Make sure the constructor fails when a bad reference is passed
    # in.
    not eval { Astro::VO::VOTable::PARAM->new(XML::LibXML::Element->new('JUNK')) }
      or return(0);
    not eval { Astro::VO::VOTable::PARAM->new(\0) } or return(0);
    not eval { Astro::VO::VOTable::PARAM->new([]) } or return(0);

    #--------------------------------------------------------------------------

    # Return success.
    return(1);

}

sub test_get_ID()
{

    my($param);

    # Read ID from a new PARAM.
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $param->setAttribute('ID', 'test');
    $param->get_ID eq 'test' or return(0);

    # Read ID from a empty PARAM.
    $param->removeAttribute('ID');
    not defined($param->get_ID) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_ID()
{

    my($param);

    # Set then read ID from a new PARAM.
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $param->set_ID('test');
    $param->get_ID eq 'test' or return(0);

    # Read ID from a empty PARAM.
    $param->set_ID('');
    $param->get_ID eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_unit()
{

    my($param);

    # Read unit from a new PARAM.
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $param->setAttribute('unit', 'test');
    $param->get_unit eq 'test' or return(0);

    # Read unit from a empty PARAM.
    $param->removeAttribute('unit');
    not defined($param->get_unit) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_unit()
{

    my($param);

    # Set then read unit from a new PARAM.
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $param->set_unit('test');
    $param->get_unit eq 'test' or return(0);

    # Read unit from a empty PARAM.
    $param->set_unit('');
    $param->get_unit eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_datatype()
{
    my($param);
    my($datatype);
    my(@valids) = qw(boolean bit unsignedByte short int long char unicodeChar
		     float double floatComplex doubleComplex);

    # Create the object.
    $param = Astro::VO::VOTable::PARAM->new or return(0);

    # Try each of the valid values.
    foreach $datatype (@valids) {
	$param->setAttribute('datatype', $datatype);
	$param->get_datatype eq $datatype or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_set_datatype()
{
    my($param);
    my($datatype);
    my(@valids) = qw(boolean bit unsignedByte short int long char unicodeChar
		     float double floatComplex doubleComplex);

    # Create the object.
    $param = Astro::VO::VOTable::PARAM->new or return(0);

    # Try each of the valid values.
    foreach $datatype (@valids) {
	$param->set_datatype($datatype);
	$param->get_datatype eq $datatype or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_get_precision()
{

    my($param);

    # Read precision from a new PARAM.
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $param->setAttribute('precision', 'test');
    $param->get_precision eq 'test' or return(0);

    # Read precision from a empty PARAM.
    $param->removeAttribute('precision');
    not defined($param->get_precision) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_precision()
{

    my($param);

    # Set then read precision from a new PARAM.
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $param->set_precision('test');
    $param->get_precision eq 'test' or return(0);

    # Read precision from a empty PARAM.
    $param->set_precision('');
    $param->get_precision eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_width()
{

    my($param);

    # Read width from a new PARAM.
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $param->setAttribute('width', 'test');
    $param->get_width eq 'test' or return(0);

    # Read width from a empty PARAM.
    $param->removeAttribute('width');
    not defined($param->get_width) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_width()
{

    my($param);

    # Set then read width from a new PARAM.
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $param->set_width('test');
    $param->get_width eq 'test' or return(0);

    # Read width from a empty PARAM.
    $param->set_width('');
    $param->get_width eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_ref()
{

    my($param);

    # Read ref from a new PARAM.
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $param->setAttribute('ref', 'test');
    $param->get_ref eq 'test' or return(0);

    # Read ref from a empty PARAM.
    $param->removeAttribute('ref');
    not defined($param->get_ref) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_ref()
{

    my($param);

    # Set then read ref from a new PARAM.
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $param->set_ref('test');
    $param->get_ref eq 'test' or return(0);

    # Read ref from a empty PARAM.
    $param->set_ref('');
    $param->get_ref eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_name()
{

    my($param);

    # Read name from a new PARAM.
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $param->setAttribute('name', 'test');
    $param->get_name eq 'test' or return(0);

    # Read name from a empty PARAM.
    $param->removeAttribute('name');
    not defined($param->get_name) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_name()
{

    my($param);

    # Set then read name from a new PARAM.
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $param->set_name('test');
    $param->get_name eq 'test' or return(0);

    # Read name from a empty PARAM.
    $param->set_name('');
    $param->get_name eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_ucd()
{

    my($param);

    # Read ucd from a new PARAM.
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $param->setAttribute('ucd', 'test');
    $param->get_ucd eq 'test' or return(0);

    # Read ucd from a empty PARAM.
    $param->removeAttribute('ucd');
    not defined($param->get_ucd) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_ucd()
{

    my($param);

    # Set then read ucd from a new PARAM.
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $param->set_ucd('test');
    $param->get_ucd eq 'test' or return(0);

    # Read ucd from a empty PARAM.
    $param->set_ucd('');
    $param->get_ucd eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_value()
{

    my($param);

    # Read value from a new PARAM.
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $param->setAttribute('value', 'test');
    $param->get_value eq 'test' or return(0);

    # Read value from a empty PARAM.
    $param->removeAttribute('value');
    not defined($param->get_value) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_value()
{

    my($param);

    # Set then read value from a new PARAM.
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $param->set_value('test');
    $param->get_value eq 'test' or return(0);

    # Read value from a empty PARAM.
    $param->set_value('');
    $param->get_value eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_arraysize()
{

    my($param);

    # Read arraysize from a new PARAM.
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $param->setAttribute('arraysize', 'test');
    $param->get_arraysize eq 'test' or return(0);

    # Read arraysize from a empty PARAM.
    $param->removeAttribute('arraysize');
    not defined($param->get_arraysize) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_arraysize()
{

    my($param);

    # Set then read arraysize from a new PARAM.
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $param->set_arraysize('test');
    $param->get_arraysize eq 'test' or return(0);

    # Read arraysize from a empty PARAM.
    $param->set_arraysize('');
    $param->get_arraysize eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_DESCRIPTION()
{
    my($param);
    my($description);

    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $description = Astro::VO::VOTable::DESCRIPTION->new or return(0);
    $param->appendChild($description);
    $description->isSameNode($param->get_DESCRIPTION(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_DESCRIPTION()
{
    my($param);
    my($description);

    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $description = Astro::VO::VOTable::DESCRIPTION->new or return(0);
    $param->set_DESCRIPTION($description);
    $description->isSameNode($param->get_DESCRIPTION(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_VALUES()
{
    my($param);
    my($values);

    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $values = Astro::VO::VOTable::VALUES->new or return(0);
    $param->appendChild($values);
    $values->isSameNode($param->get_VALUES(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_VALUES()
{
    my($param);
    my($values);

    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $values = Astro::VO::VOTable::VALUES->new or return(0);
    $param->set_VALUES($values);
    $values->isSameNode($param->get_VALUES(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_LINK()
{
    my($param);
    my($link);

    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $link = Astro::VO::VOTable::LINK->new or return(0);
    $param->appendChild($link);
    $link->isSameNode($param->get_LINK(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_LINK()
{
    my($param);
    my($link);

    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $link = Astro::VO::VOTable::LINK->new or return(0);
    $param->set_LINK($link);
    $link->isSameNode($param->get_LINK(0)) or return(0);

    # All tests passed.
    return(1);

}
