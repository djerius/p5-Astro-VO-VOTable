# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 8 };
use Astro::VO::VOTable::MIN;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

#########################

# External modules

# Subroutine prototypes
sub test_new();
sub test_get_value();
sub test_set_value();
sub test_get_inclusive();
sub test_set_inclusive();
sub test_get();
sub test_set();

#########################

# Test.
ok(test_new, 1);
ok(test_get_value, 1);
ok(test_set_value, 1);
ok(test_get_inclusive, 1);
ok(test_set_inclusive, 1);
ok(test_get, 1);
ok(test_set, 1);

#########################

sub test_new()
{

    # Test the plain-vanilla constructor.
    Astro::VO::VOTable::MIN->new or return(0);

    # Try creating from a XML::LibXML::Element object.
    Astro::VO::VOTable::MIN->new(XML::LibXML::Element->new('MIN')) or return(0);

    # Make sure the constructor fails when a bad reference is passed
    # in.
    not eval { Astro::VO::VOTable::MIN->new(XML::LibXML::Element->new('JUNK')) }
      or return(0);
    not eval { Astro::VO::VOTable::MIN->new(\0) } or return(0);
    not eval { Astro::VO::VOTable::MIN->new([]) } or return(0);

    #--------------------------------------------------------------------------

    # Return success.
    return(1);

}

sub test_get_value()
{
    my($min);

    # Create the object.
    $min = Astro::VO::VOTable::MIN->new or return(0);

    # Try each of the valid values.
    $min->setAttribute('value', 'This is a test!');
    $min->get_value eq 'This is a test!' or return(0);

    # All tests passed.
    return(1);

}

sub test_set_value()
{
    my($min);

    # Create the object.
    $min = Astro::VO::VOTable::MIN->new or return(0);

    # Try each of the valid values.
    $min->set_value('This is also a test!');
    $min->get_value eq 'This is also a test!' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_inclusive()
{
    my($min);

    # Create the object.
    $min = Astro::VO::VOTable::MIN->new or return(0);

    # Try each of the valid inclusives.
    $min->setAttribute('inclusive', 'yes');
    $min->get_inclusive eq 'yes' or return(0);

    # All tests passed.
    return(1);

}

sub test_set_inclusive()
{
    my($min);

    # Create the object.
    $min = Astro::VO::VOTable::MIN->new or return(0);

    # Try each of the valid inclusives.
    $min->set_inclusive('no');
    $min->get_inclusive eq 'no' or return(0);

    # All tests passed.
    return(1);

}

sub test_get()
{
    my($min);

    # Create the object.
    $min = Astro::VO::VOTable::MIN->new or return(0);

    # Add then read the text.
    $min->appendChild(XML::LibXML::Text->new('0.0'));
    $min->get eq '0.0' or return(0);

    # All tests passed.
    return(1);

}

sub test_set()
{
    my($min);

    # Create the object.
    $min = Astro::VO::VOTable::MIN->new or return(0);

    # Add then read the text.
    $min->set('0.0');
    $min->get eq '0.0' or return(0);

    # All tests passed.
    return(1);

}
