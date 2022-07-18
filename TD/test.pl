# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 6 };
use Astro::VO::VOTable::TD;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

#########################

# External modules

# Subroutine prototypes
sub test_new();
sub test_get_ref();
sub test_set_ref();
sub test_get();
sub test_set();

#########################

# Test.
ok(test_new, 1);
ok(test_get_ref, 1);
ok(test_set_ref, 1);
ok(test_get, 1);
ok(test_set, 1);

#########################

sub test_new()
{

    # Test the plain-vanilla constructor.
    Astro::VO::VOTable::TD->new or return(0);

    # Try creating from a XML::LibXML::Element object.
    Astro::VO::VOTable::TD->new(XML::LibXML::Element->new('TD')) or return(0);

    # Make sure the constructor fails when a bad reference is passed
    # in.
    not eval { Astro::VO::VOTable::TD->new(XML::LibXML::Element->new('JUNK')) }
      or return(0);
    not eval { Astro::VO::VOTable::TD->new(\0) } or return(0);
    not eval { Astro::VO::VOTable::TD->new([]) } or return(0);

    #--------------------------------------------------------------------------

    # Return success.
    return(1);

}
 
sub test_get_ref()
{
    my($td);

    # Create the object.
    $td = Astro::VO::VOTable::TD->new or return(0);

    # Try each of the valid values.
    $td->setAttribute('ref', '9999');
    $td->get_ref eq '9999' or return(0);

    # All tests passed.
    return(1);

}

sub test_set_ref()
{
    my($td);

    # Create the object.
    $td = Astro::VO::VOTable::TD->new or return(0);

    # Try each of the valid values.
    $td->set_ref('1111');
    $td->get_ref eq '1111' or return(0);

    # All tests passed.
    return(1);

}

sub test_get()
{
    my($td);

    # Create the object.
    $td = Astro::VO::VOTable::TD->new or return(0);

    # Add then read the text.
    $td->appendChild(XML::LibXML::Text->new('This is a test.'));
    $td->get eq 'This is a test.' or return(0);

    # All tests passed.
    return(1);

}

sub test_set()
{
    my($td);

    # Create the object.
    $td = Astro::VO::VOTable::TD->new or return(0);

    # Add then read the text.
    $td->set('This is a test.');
    $td->get eq 'This is a test.' or return(0);

    # All tests passed.
    return(1);

}
