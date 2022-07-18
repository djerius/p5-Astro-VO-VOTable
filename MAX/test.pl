# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 8 };
use Astro::VO::VOTable::MAX;
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
    Astro::VO::VOTable::MAX->new or return(0);

    # Try creating from a XML::LibXML::Element object.
    Astro::VO::VOTable::MAX->new(XML::LibXML::Element->new('MAX')) or return(0);

    # Make sure the constructor fails when a bad reference is passed
    # in.
    not eval { Astro::VO::VOTable::MAX->new(XML::LibXML::Element->new('JUNK')) }
      or return(0);
    not eval { Astro::VO::VOTable::MAX->new(\0) } or return(0);
    not eval { Astro::VO::VOTable::MAX->new([]) } or return(0);

    #--------------------------------------------------------------------------

    # Return success.
    return(1);

}

sub test_get_value()
{
    my($max);

    # Create the object.
    $max = Astro::VO::VOTable::MAX->new or return(0);

    # Try each of the valid values.
    $max->setAttribute('value', 'This is a test!');
    $max->get_value eq 'This is a test!' or return(0);

    # All tests passed.
    return(1);

}

sub test_set_value()
{
    my($max);

    # Create the object.
    $max = Astro::VO::VOTable::MAX->new or return(0);

    # Try each of the valid values.
    $max->set_value('This is also a test!');
    $max->get_value eq 'This is also a test!' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_inclusive()
{
    my($max);

    # Create the object.
    $max = Astro::VO::VOTable::MAX->new or return(0);

    # Try each of the valid inclusives.
    $max->setAttribute('inclusive', 'yes');
    $max->get_inclusive eq 'yes' or return(0);

    # All tests passed.
    return(1);

}

sub test_set_inclusive()
{
    my($max);

    # Create the object.
    $max = Astro::VO::VOTable::MAX->new or return(0);

    # Try each of the valid inclusives.
    $max->set_inclusive('no');
    $max->get_inclusive eq 'no' or return(0);

    # All tests passed.
    return(1);

}

sub test_get()
{
    my($max);

    # Create the object.
    $max = Astro::VO::VOTable::MAX->new or return(0);

    # Add then read the text.
    $max->appendChild(XML::LibXML::Text->new('Infinity'));
    $max->get eq 'Infinity' or return(0);

    # All tests passed.
    return(1);

}

sub test_set()
{
    my($max);

    # Create the object.
    $max = Astro::VO::VOTable::MAX->new or return(0);

    # Add then read the text.
    $max->set('Infinity');
    $max->get eq 'Infinity' or return(0);

    # All tests passed.
    return(1);

}
