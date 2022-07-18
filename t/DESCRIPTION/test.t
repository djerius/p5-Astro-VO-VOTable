# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 3 };
use Astro::VO::VOTable::DESCRIPTION;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

#########################

# External modules

# Subroutine prototypes
sub test_get();
sub test_set();

#########################

# Test.
ok(test_get, 1);
ok(test_set, 1);

#########################

sub test_get()
{
    my($description);

    # Create the object.
    $description = Astro::VO::VOTable::DESCRIPTION->new or return(0);

    # Add then read the text.
    $description->appendChild(XML::LibXML::Text->new('This is a test.'));
    $description->get eq 'This is a test.' or return(0);

    # All tests passed.
    return(1);

}

sub test_set()
{
    my($description);

    # Create the object.
    $description = Astro::VO::VOTable::DESCRIPTION->new or return(0);

    # Add then read the text.
    $description->set('This is a test.');
    $description->get eq 'This is a test.' or return(0);

    # All tests passed.
    return(1);

}
