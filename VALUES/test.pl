# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 16 };
use Astro::VO::VOTable::VALUES;
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
sub test_get_type();
sub test_set_type();
sub test_get_null();
sub test_set_null();
sub test_get_invalid();
sub test_set_invalid();
sub test_get_MIN();
sub test_set_MIN();
sub test_get_MAX();
sub test_set_MAX();
sub test_get_OPTION();
sub test_set_OPTION();

#########################

# Test.
ok(test_new, 1);
ok(test_get_ID, 1);
ok(test_set_ID, 1);
ok(test_get_type, 1);
ok(test_set_type, 1);
ok(test_get_null, 1);
ok(test_set_null, 1);
ok(test_get_invalid, 1);
ok(test_set_invalid, 1);
ok(test_get_MIN, 1);
ok(test_set_MIN, 1);
ok(test_get_MAX, 1);
ok(test_set_MAX, 1);
ok(test_get_OPTION, 1);
ok(test_set_OPTION, 1);

#########################

sub test_new() {

    # Test the plain-vanilla constructor.
    Astro::VO::VOTable::VALUES->new or return(0);

    # Try creating from a XML::LibXML::Element object.
    Astro::VO::VOTable::VALUES->new(XML::LibXML::Element->new('VALUES')) or return(0);

    # Make sure the constructor fails when a bad reference is passed
    # in.
    not eval { Astro::VO::VOTable::VALUES->new(XML::LibXML::Element->new('JUNK')) }
      or return(0);
    not eval { Astro::VO::VOTable::VALUES->new(\0) } or return(0);
    not eval { Astro::VO::VOTable::VALUES->new([]) } or return(0);

    #--------------------------------------------------------------------------

    # Return success.
    return(1);

}

sub test_get_ID()
{

    my($values);

    # Read ID from a new VALUES.
    $values = Astro::VO::VOTable::VALUES->new or return(0);
    $values->setAttribute('ID', 'test');
    $values->get_ID eq 'test' or return(0);

    # Read ID from a empty VALUES.
    $values->removeAttribute('ID');
    not defined($values->get_ID) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_ID()
{

    my($values);

    # Set then read ID from a new VALUES.
    $values = Astro::VO::VOTable::VALUES->new or return(0);
    $values->set_ID('test');
    $values->get_ID eq 'test' or return(0);

    # Read ID from a empty VALUES.
    $values->set_ID('');
    $values->get_ID eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_type()
{
    my($values);
    my($type);
    my(@valids) = qw(legal actual);

    # Create the object.
    $values = Astro::VO::VOTable::VALUES->new or return(0);

    # Try each of the valid values.
    foreach $type (@valids) {
	$values->setAttribute('type', $type);
	$values->get_type eq $type or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_set_type()
{
    my($values);
    my($type);
    my(@valids) = qw(legal actual);

    # Create the object.
    $values = Astro::VO::VOTable::VALUES->new or return(0);

    # Try each of the valid values.
    foreach $type (@valids) {
	$values->set_type($type);
	$values->get_type eq $type or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_get_null()
{

    my($values);

    # Read null from a new VALUES.
    $values = Astro::VO::VOTable::VALUES->new or return(0);
    $values->setAttribute('null', 'test');
    $values->get_null eq 'test' or return(0);

    # Read null from a empty VALUES.
    $values->removeAttribute('null');
    not defined($values->get_null) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_null()
{

    my($values);

    # Set then read null from a new VALUES.
    $values = Astro::VO::VOTable::VALUES->new or return(0);
    $values->set_null('test');
    $values->get_null eq 'test' or return(0);

    # Read null from a empty VALUES.
    $values->set_null('');
    $values->get_null eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_invalid()
{
    my($values);
    my($invalid);
    my(@valids) = qw(yes no);

    # Create the object.
    $values = Astro::VO::VOTable::VALUES->new or return(0);

    # Try each of the valid values.
    foreach $invalid (@valids) {
	$values->setAttribute('invalid', $invalid);
	$values->get_invalid eq $invalid or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_set_invalid()
{
    my($values);
    my($invalid);
    my(@valids) = qw(yes no);

    # Create the object.
    $values = Astro::VO::VOTable::VALUES->new or return(0);

    # Try each of the valid values.
    foreach $invalid (@valids) {
	$values->set_invalid($invalid);
	$values->get_invalid eq $invalid or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_get_MIN()
{
    my($values);
    my($min);

    $values = Astro::VO::VOTable::VALUES->new or return(0);
    $min = Astro::VO::VOTable::MIN->new or return(0);
    $values->appendChild($min);
    $min->isSameNode($values->get_MIN(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_MIN()
{
    my($values);
    my($min);

    $values = Astro::VO::VOTable::VALUES->new or return(0);
    $min = Astro::VO::VOTable::MIN->new or return(0);
    $values->set_MIN($min);
    $min->isSameNode($values->get_MIN(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_MAX()
{
    my($values);
    my($max);

    $values = Astro::VO::VOTable::VALUES->new or return(0);
    $max = Astro::VO::VOTable::MAX->new or return(0);
    $values->appendChild($max);
    $max->isSameNode($values->get_MAX(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_MAX()
{
    my($values);
    my($max);

    $values = Astro::VO::VOTable::VALUES->new or return(0);
    $max = Astro::VO::VOTable::MAX->new or return(0);
    $values->set_MAX($max);
    $max->isSameNode($values->get_MAX(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_OPTION()
{
    my($values);
    my($option);

    $values = Astro::VO::VOTable::VALUES->new or return(0);
    $option = Astro::VO::VOTable::OPTION->new or return(0);
    $values->appendChild($option);
    $option->isSameNode($values->get_OPTION(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_OPTION()
{
    my($values);
    my($option);

    $values = Astro::VO::VOTable::VALUES->new or return(0);
    $option = Astro::VO::VOTable::OPTION->new or return(0);
    $values->set_OPTION($option);
    $option->isSameNode($values->get_OPTION(0)) or return(0);

    # All tests passed.
    return(1);

}
