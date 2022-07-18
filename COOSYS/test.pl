# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 12 };
use Astro::VO::VOTable::COOSYS;
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
sub test_get_equinox();
sub test_set_equinox();
sub test_get_epoch();
sub test_set_epoch();
sub test_get_system();
sub test_set_system();
sub test_get();
sub test_set();

#########################

# Test.
ok(test_new, 1);
ok(test_get_ID, 1);
ok(test_set_ID, 1);
ok(test_get_equinox, 1);
ok(test_set_equinox, 1);
ok(test_get_epoch, 1);
ok(test_set_epoch, 1);
ok(test_get_system, 1);
ok(test_set_system, 1);
ok(test_get, 1);
ok(test_set, 1);

#########################

sub test_new()
{

    # Test the plain-vanilla constructor.
    Astro::VO::VOTable::COOSYS->new or return(0);

    # Try creating from a XML::LibXML::Element object.
    Astro::VO::VOTable::COOSYS->new(XML::LibXML::Element->new('COOSYS')) or return(0);

    # Make sure the constructor fails when a bad reference is passed
    # in.
    not eval { Astro::VO::VOTable::COOSYS->new(XML::LibXML::Element->new('JUNK')) }
      or return(0);
    not eval { Astro::VO::VOTable::COOSYS->new(\0) } or return(0);
    not eval { Astro::VO::VOTable::COOSYS->new([]) } or return(0);

    #--------------------------------------------------------------------------

    # Return success.
    return(1);

}

sub test_get_ID()
{

    my($coosys);

    # Read ID from a new COOSYS.
    $coosys = Astro::VO::VOTable::COOSYS->new or return(0);
    $coosys->setAttribute('ID', 'test');
    $coosys->get_ID eq 'test' or return(0);

    # Read ID from a empty COOSYS.
    $coosys->removeAttribute('ID');
    not defined($coosys->get_ID) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_ID()
{

    my($coosys);

    # Set then read ID from a new COOSYS.
    $coosys = Astro::VO::VOTable::COOSYS->new or return(0);
    $coosys->set_ID('test');
    $coosys->get_ID eq 'test' or return(0);

    # Read ID from a empty COOSYS.
    $coosys->set_ID('');
    $coosys->get_ID eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_equinox()
{

    my($coosys);

    # Read equinox from a new COOSYS.
    $coosys = Astro::VO::VOTable::COOSYS->new or return(0);
    $coosys->setAttribute('equinox', 'J2000');
    $coosys->get_equinox eq 'J2000' or return(0);

    # Read equinox from a empty COOSYS.
    $coosys->removeAttribute('equinox');
    not defined($coosys->get_equinox) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_equinox()
{

    my($coosys);

    # Set then read equinox from a new COOSYS.
    $coosys = Astro::VO::VOTable::COOSYS->new or return(0);
    $coosys->set_equinox('J2000');
    $coosys->get_equinox eq 'J2000' or return(0);

    # Read equinox from a empty COOSYS.
    $coosys->set_equinox('');
    $coosys->get_equinox eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_epoch()
{

    my($coosys);

    # Read epoch from a new COOSYS.
    $coosys = Astro::VO::VOTable::COOSYS->new or return(0);
    $coosys->setAttribute('epoch', 'J2000');
    $coosys->get_epoch eq 'J2000' or return(0);

    # Read epoch from a empty COOSYS.
    $coosys->removeAttribute('epoch');
    not defined($coosys->get_epoch) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_epoch()
{

    my($coosys);

    # Set then read epoch from a new COOSYS.
    $coosys = Astro::VO::VOTable::COOSYS->new or return(0);
    $coosys->set_epoch('J2000');
    $coosys->get_epoch eq 'J2000' or return(0);

    # Read epoch from a empty COOSYS.
    $coosys->set_epoch('');
    $coosys->get_epoch eq '' or return(0);

    # All tests passed.
    return(1);

}


sub test_get_system()
{
    my($coosys);
    my($system);
    my(@valids) = qw(eq_FK4 eq_FK5 ICRS ecl_FK4 ecl_FK5 galactic
		     supergalactic xy barycentric geo_app);

    # Create the object.
    $coosys = Astro::VO::VOTable::COOSYS->new or return(0);

    # Try each of the valid values.
    foreach $system (@valids) {
	$coosys->setAttribute('system', $system);
	$coosys->get_system eq $system or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_set_system()
{
    my($coosys);
    my($system);
    my(@valids) = qw(eq_FK4 eq_FK5 ICRS ecl_FK4 ecl_FK5 galactic
		     supergalactic xy barycentric geo_app);

    # Create the object.
    $coosys = Astro::VO::VOTable::COOSYS->new or return(0);

    # Try each of the valid values.
    foreach $system (@valids) {
	$coosys->set_system($system);
	$coosys->get_system eq $system or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_get()
{
    my($coosys);

    # Create the object.
    $coosys = Astro::VO::VOTable::COOSYS->new or return(0);

    # Add then read the text.
    $coosys->appendChild(XML::LibXML::Text->new('This is a test.'));
    $coosys->get eq 'This is a test.' or return(0);

    # All tests passed.
    return(1);

}

sub test_set()
{
    my($coosys);

    # Create the object.
    $coosys = Astro::VO::VOTable::COOSYS->new or return(0);

    # Add then read the text.
    $coosys->set('This is a test.');
    $coosys->get eq 'This is a test.' or return(0);

    # All tests passed.
    return(1);

}
