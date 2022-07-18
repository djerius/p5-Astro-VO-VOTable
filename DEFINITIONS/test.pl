# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 6 };
use Astro::VO::VOTable::DEFINITIONS;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

#########################

# External modules

# Subroutine prototypes
sub test_new();
sub test_get_COOSYS();
sub test_set_COOSYS();
sub test_get_PARAM();
sub test_set_PARAM();

#########################

# Test.
ok(test_new, 1);
ok(test_get_COOSYS, 1);
ok(test_set_COOSYS, 1);
ok(test_get_PARAM, 1);
ok(test_set_PARAM, 1);

#########################

sub test_new()
{

    # Test the plain-vanilla constructor.
    Astro::VO::VOTable::DEFINITIONS->new or return(0);

    # Try creating from a XML::LibXML::Element object.
    Astro::VO::VOTable::DEFINITIONS->
	new(XML::LibXML::Element->new('DEFINITIONS')) or return(0);

    # Make sure the constructor fails when a bad reference is passed
    # in.
    not eval { Astro::VO::VOTable::DEFINITIONS->
		   new(XML::LibXML::Element->new('JUNK')) } or return(0);
    not eval { Astro::VO::VOTable::DEFINITIONS->new(\0) } or return(0);
    not eval { Astro::VO::VOTable::DEFINITIONS->new([]) } or return(0);

    #--------------------------------------------------------------------------

    # Return success.
    return(1);

}

sub test_get_COOSYS()
{
    my($definitions);
    my($coosys);

    $definitions = Astro::VO::VOTable::DEFINITIONS->new or return(0);
    $coosys = Astro::VO::VOTable::COOSYS->new or return(0);
    $definitions->appendChild($coosys);
    $coosys->isSameNode($definitions->get_COOSYS(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_COOSYS()
{
    my($definitions);
    my($coosys);

    $definitions = Astro::VO::VOTable::DEFINITIONS->new or return(0);
    $coosys = Astro::VO::VOTable::COOSYS->new or return(0);
    $definitions->set_COOSYS($coosys);
    $coosys->isSameNode($definitions->get_COOSYS(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_PARAM()
{
    my($definitions);
    my($param);

    $definitions = Astro::VO::VOTable::DEFINITIONS->new or return(0);
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $definitions->appendChild($param);
    $param->isSameNode($definitions->get_PARAM(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_PARAM()
{
    my($definitions);
    my($param);

    $definitions = Astro::VO::VOTable::DEFINITIONS->new or return(0);
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $definitions->set_PARAM($param);
    $param->isSameNode($definitions->get_PARAM(0)) or return(0);

    # All tests passed.
    return(1);

}
