# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 28 };
use Astro::VO::VOTable::FIELD;
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
sub test_get_arraysize();
sub test_set_arraysize();
sub test_get_type();
sub test_set_type();
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
ok(test_get_arraysize, 1);
ok(test_set_arraysize, 1);
ok(test_get_type, 1);
ok(test_set_type, 1);
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
    Astro::VO::VOTable::FIELD->new or return(0);

    # Try creating from a XML::LibXML::Element object.
    Astro::VO::VOTable::FIELD->new(XML::LibXML::Element->new('FIELD')) or return(0);

    # Make sure the constructor fails when a bad reference is passed
    # in.
    not eval { Astro::VO::VOTable::FIELD->new(XML::LibXML::Element->new('JUNK')) }
      or return(0);
    not eval { Astro::VO::VOTable::FIELD->new(\0) } or return(0);
    not eval { Astro::VO::VOTable::FIELD->new([]) } or return(0);

    #--------------------------------------------------------------------------

    # Return success.
    return(1);

}

sub test_get_ID()
{

    my($field);

    # Read ID from a new FIELD.
    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $field->setAttribute('ID', 'test');
    $field->get_ID eq 'test' or return(0);

    # Read ID from a empty FIELD.
    $field->removeAttribute('ID');
    not defined($field->get_ID) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_ID()
{

    my($field);

    # Set then read ID from a new FIELD.
    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $field->set_ID('test');
    $field->get_ID eq 'test' or return(0);

    # Read ID from a empty FIELD.
    $field->set_ID('');
    $field->get_ID eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_unit()
{

    my($field);

    # Read unit from a new FIELD.
    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $field->setAttribute('unit', 'test');
    $field->get_unit eq 'test' or return(0);

    # Read unit from a empty FIELD.
    $field->removeAttribute('unit');
    not defined($field->get_unit) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_unit()
{

    my($field);

    # Set then read unit from a new FIELD.
    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $field->set_unit('test');
    $field->get_unit eq 'test' or return(0);

    # Read unit from a empty FIELD.
    $field->set_unit('');
    $field->get_unit eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_datatype()
{
    my($field);
    my($datatype);
    my(@valids) = qw(boolean bit unsignedByte short int long char unicodeChar
		     float double floatComplex doubleComplex);

    # Create the object.
    $field = Astro::VO::VOTable::FIELD->new or return(0);

    # Try each of the valid values.
    foreach $datatype (@valids) {
	$field->setAttribute('datatype', $datatype);
	$field->get_datatype eq $datatype or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_set_datatype()
{
    my($field);
    my($datatype);
    my(@valids) = qw(boolean bit unsignedByte short int long char unicodeChar
		     float double floatComplex doubleComplex);

    # Create the object.
    $field = Astro::VO::VOTable::FIELD->new or return(0);

    # Try each of the valid values.
    foreach $datatype (@valids) {
	$field->set_datatype($datatype);
	$field->get_datatype eq $datatype or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_get_precision()
{

    my($field);

    # Read precision from a new FIELD.
    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $field->setAttribute('precision', 'test');
    $field->get_precision eq 'test' or return(0);

    # Read precision from a empty FIELD.
    $field->removeAttribute('precision');
    not defined($field->get_precision) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_precision()
{

    my($field);

    # Set then read precision from a new FIELD.
    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $field->set_precision('test');
    $field->get_precision eq 'test' or return(0);

    # Read precision from a empty FIELD.
    $field->set_precision('');
    $field->get_precision eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_width()
{

    my($field);

    # Read width from a new FIELD.
    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $field->setAttribute('width', 'test');
    $field->get_width eq 'test' or return(0);

    # Read width from a empty FIELD.
    $field->removeAttribute('width');
    not defined($field->get_width) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_width()
{

    my($field);

    # Set then read width from a new FIELD.
    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $field->set_width('test');
    $field->get_width eq 'test' or return(0);

    # Read width from a empty FIELD.
    $field->set_width('');
    $field->get_width eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_ref()
{

    my($field);

    # Read ref from a new FIELD.
    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $field->setAttribute('ref', 'test');
    $field->get_ref eq 'test' or return(0);

    # Read ref from a empty FIELD.
    $field->removeAttribute('ref');
    not defined($field->get_ref) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_ref()
{

    my($field);

    # Set then read ref from a new FIELD.
    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $field->set_ref('test');
    $field->get_ref eq 'test' or return(0);

    # Read ref from a empty FIELD.
    $field->set_ref('');
    $field->get_ref eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_name()
{

    my($field);

    # Read name from a new FIELD.
    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $field->setAttribute('name', 'test');
    $field->get_name eq 'test' or return(0);

    # Read name from a empty FIELD.
    $field->removeAttribute('name');
    not defined($field->get_name) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_name()
{

    my($field);

    # Set then read name from a new FIELD.
    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $field->set_name('test');
    $field->get_name eq 'test' or return(0);

    # Read name from a empty FIELD.
    $field->set_name('');
    $field->get_name eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_ucd()
{

    my($field);

    # Read ucd from a new FIELD.
    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $field->setAttribute('ucd', 'test');
    $field->get_ucd eq 'test' or return(0);

    # Read ucd from a empty FIELD.
    $field->removeAttribute('ucd');
    not defined($field->get_ucd) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_ucd()
{

    my($field);

    # Set then read ucd from a new FIELD.
    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $field->set_ucd('test');
    $field->get_ucd eq 'test' or return(0);

    # Read ucd from a empty FIELD.
    $field->set_ucd('');
    $field->get_ucd eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_arraysize()
{

    my($field);

    # Read arraysize from a new FIELD.
    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $field->setAttribute('arraysize', 'test');
    $field->get_arraysize eq 'test' or return(0);

    # Read arraysize from a empty FIELD.
    $field->removeAttribute('arraysize');
    not defined($field->get_arraysize) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_arraysize()
{

    my($field);

    # Set then read arraysize from a new FIELD.
    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $field->set_arraysize('test');
    $field->get_arraysize eq 'test' or return(0);

    # Read arraysize from a empty FIELD.
    $field->set_arraysize('');
    $field->get_arraysize eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_type()
{
    my($field);
    my($type);
    my(@valids) = qw(hidden no_query trigger);

    # Create the object.
    $field = Astro::VO::VOTable::FIELD->new or return(0);

    # Try each of the valid values.
    foreach $type (@valids) {
	$field->setAttribute('type', $type);
	$field->get_type eq $type or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_set_type()
{
    my($field);
    my($type);
    my(@valids) = qw(hidden no_query trigger);

    # Create the object.
    $field = Astro::VO::VOTable::FIELD->new or return(0);

    # Try each of the valid values.
    foreach $type (@valids) {
	$field->set_type($type);
	$field->get_type eq $type or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_get_DESCRIPTION()
{
    my($field);
    my($description);

    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $description = Astro::VO::VOTable::DESCRIPTION->new or return(0);
    $field->appendChild($description);
    $description->isSameNode($field->get_DESCRIPTION(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_DESCRIPTION()
{
    my($field);
    my($description);

    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $description = Astro::VO::VOTable::DESCRIPTION->new or return(0);
    $field->set_DESCRIPTION($description);
    $description->isSameNode($field->get_DESCRIPTION(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_VALUES()
{
    my($field);
    my($values);

    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $values = Astro::VO::VOTable::VALUES->new or return(0);
    $field->appendChild($values);
    $values->isSameNode($field->get_VALUES(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_VALUES()
{
    my($field);
    my($values);

    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $values = Astro::VO::VOTable::VALUES->new or return(0);
    $field->set_VALUES($values);
    $values->isSameNode($field->get_VALUES(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_LINK()
{
    my($field);
    my($link);

    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $link = Astro::VO::VOTable::LINK->new or return(0);
    $field->appendChild($link);
    $link->isSameNode($field->get_LINK(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_LINK()
{
    my($field);
    my($link);

    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $link = Astro::VO::VOTable::LINK->new or return(0);
    $field->set_LINK($link);
    $link->isSameNode($field->get_LINK(0)) or return(0);

    # All tests passed.
    return(1);

}
