# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 8 };
use Astro::VO::VOTable::OPTION;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

#########################

# External modules

# Subroutine prototypes
sub test_new();
sub test_get_name();
sub test_set_name();
sub test_get_value();
sub test_set_value();
sub test_get_OPTION();
sub test_set_OPTION();

#########################

# Test.
ok(test_new, 1);
ok(test_get_name, 1);
ok(test_set_name, 1);
ok(test_get_value, 1);
ok(test_set_value, 1);
ok(test_get_OPTION, 1);
ok(test_set_OPTION, 1);

#########################

sub test_new()
{

    # Test the plain-vanilla constructor.
    Astro::VO::VOTable::OPTION->new or return(0);

    # Try creating from a XML::LibXML::Element object.
    Astro::VO::VOTable::OPTION->new(XML::LibXML::Element->new('OPTION')) or return(0);

    # Make sure the constructor fails when a bad reference is passed
    # in.
    not eval { Astro::VO::VOTable::OPTION->new(XML::LibXML::Element->new('JUNK')) }
      or return(0);
    not eval { Astro::VO::VOTable::OPTION->new(\0) } or return(0);
    not eval { Astro::VO::VOTable::OPTION->new([]) } or return(0);

    #--------------------------------------------------------------------------

    # Return success.
    return(1);

}

sub test_get_name()
{
    my($option);

    # Create the object.
    $option = Astro::VO::VOTable::OPTION->new or return(0);

    # Set and read the name.
    $option->setAttribute('name', 'test');
    $option->get_name eq 'test' or return(0);

    # All tests passed.
    return(1);

}

sub test_set_name()
{
    my($option);

    # Create the object.
    $option = Astro::VO::VOTable::OPTION->new or return(0);

    # Set and read the name.
    $option->set_name('test');
    $option->get_name eq 'test' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_value()
{
    my($option);

    # Create the object.
    $option = Astro::VO::VOTable::OPTION->new or return(0);

    # Set and read the value.
    $option->setAttribute('value', 'another test');
    $option->get_value eq 'another test' or return(0);

    # All tests passed.
    return(1);

}

sub test_set_value()
{
    my($option);

    # Create the object.
    $option = Astro::VO::VOTable::OPTION->new or return(0);

    # Set and read the value.
    $option->set_value('another test');
    $option->get_value eq 'another test' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_OPTION()
{
    my($option);
    my($sub_option);

    $option = Astro::VO::VOTable::OPTION->new or return(0);
    $sub_option = Astro::VO::VOTable::OPTION->new or return(0);
    $option->appendChild($sub_option);
    $sub_option->isSameNode($option->get_OPTION(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_OPTION()
{
    my($option);
    my($sub_option);

    $option = Astro::VO::VOTable::OPTION->new or return(0);
    $sub_option = Astro::VO::VOTable::OPTION->new or return(0);
    $option->set_OPTION($sub_option);
    $sub_option->isSameNode($option->get_OPTION(0)) or return(0);

    # All tests passed.
    return(1);

}
