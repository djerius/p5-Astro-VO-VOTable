# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 10 };
use Astro::VO::VOTable::INFO;
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
sub test_get_value();
sub test_set_value();
sub test_get();
sub test_set();

#########################

# Test.
ok(test_new, 1);
ok(test_get_ID, 1);
ok(test_set_ID, 1);
ok(test_get_name, 1);
ok(test_set_name, 1);
ok(test_get_value, 1);
ok(test_set_value, 1);
ok(test_get, 1);
ok(test_set, 1);

#########################

sub test_new()
{

    # Test the plain-vanilla constructor.
    Astro::VO::VOTable::INFO->new or return(0);

    # Try creating from a XML::LibXML::Element object.
    Astro::VO::VOTable::INFO->new(XML::LibXML::Element->new('INFO')) or return(0);

    # Make sure the constructor fails when a bad reference is passed
    # in.
    not eval { Astro::VO::VOTable::INFO->new(XML::LibXML::Element->new('JUNK')) }
      or return(0);
    not eval { Astro::VO::VOTable::INFO->new(\0) } or return(0);
    not eval { Astro::VO::VOTable::INFO->new([]) } or return(0);

    #--------------------------------------------------------------------------

    # Return success.
    return(1);

}

sub test_get_ID()
{

    my($info);

    # Read ID from a new INFO.
    $info = Astro::VO::VOTable::INFO->new or return(0);
    $info->setAttribute('ID', 'test');
    $info->get_ID eq 'test' or return(0);

    # Read ID from a empty INFO.
    $info->removeAttribute('ID');
    not defined($info->get_ID) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_ID()
{

    my($info);

    # Set then read ID from a new INFO.
    $info = Astro::VO::VOTable::INFO->new or return(0);
    $info->set_ID('test');
    $info->get_ID eq 'test' or return(0);

    # Read ID from a empty INFO.
    $info->set_ID('');
    $info->get_ID eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_name()
{

    my($info);

    # Read name from a new INFO.
    $info = Astro::VO::VOTable::INFO->new or return(0);
    $info->setAttribute('name', 'test');
    $info->get_name eq 'test' or return(0);

    # Read name from a empty INFO.
    $info->removeAttribute('name');
    not defined($info->get_name) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_name()
{

    my($info);

    # Set then read name from a new INFO.
    $info = Astro::VO::VOTable::INFO->new or return(0);
    $info->set_name('test');
    $info->get_name eq 'test' or return(0);

    # Read name from a empty INFO.
    $info->set_name('');
    $info->get_name eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_value()
{

    my($info);

    # Read value from a new INFO.
    $info = Astro::VO::VOTable::INFO->new or return(0);
    $info->setAttribute('value', 'test');
    $info->get_value eq 'test' or return(0);

    # Read value from a empty INFO.
    $info->removeAttribute('value');
    not defined($info->get_value) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_value()
{

    my($info);

    # Set then read value from a new INFO.
    $info = Astro::VO::VOTable::INFO->new or return(0);
    $info->set_value('test');
    $info->get_value eq 'test' or return(0);

    # Read value from a empty INFO.
    $info->set_value('');
    $info->get_value eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get()
{
    my($info);

    # Create the object.
    $info = Astro::VO::VOTable::INFO->new or return(0);

    # Add then read the text.
    $info->appendChild(XML::LibXML::Text->new('This is a test.'));
    $info->get eq 'This is a test.' or return(0);

    # All tests passed.
    return(1);

}

sub test_set()
{
    my($info);

    # Create the object.
    $info = Astro::VO::VOTable::INFO->new or return(0);

    # Add then read the text.
    $info->set('This is a test.');
    $info->get eq 'This is a test.' or return(0);

    # All tests passed.
    return(1);

}
