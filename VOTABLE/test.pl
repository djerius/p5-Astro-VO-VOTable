# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 14 };
use Astro::VO::VOTable::VOTABLE;
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
sub test_get_version();
sub test_set_version();
sub test_get_DESCRIPTION();
sub test_set_DESCRIPTION();
sub test_get_DEFINITIONS();
sub test_set_DEFINITIONS();
sub test_get_INFO();
sub test_set_INFO();
sub test_get_RESOURCE();
sub test_set_RESOURCE();

#########################

# Test.
ok(test_new, 1);
ok(test_get_ID, 1);
ok(test_set_ID, 1);
ok(test_get_version, 1);
ok(test_set_version, 1);
ok(test_get_DESCRIPTION, 1);
ok(test_set_DESCRIPTION, 1);
ok(test_get_DEFINITIONS, 1);
ok(test_set_DEFINITIONS, 1);
ok(test_get_INFO, 1);
ok(test_set_INFO, 1);
ok(test_get_RESOURCE, 1);
ok(test_set_RESOURCE, 1);

#########################

sub test_new()
{

    # Test the plain-vanilla constructor.
    Astro::VO::VOTable::VOTABLE->new or return(0);

    # Try creating from a XML::LibXML::Element object.
    Astro::VO::VOTable::VOTABLE->new(XML::LibXML::Element->new('VOTABLE'))
	or return(0);

    # Make sure the constructor fails when a bad reference is passed
    # in.
    not eval {
	Astro::VO::VOTable::VOTABLE->new(XML::LibXML::Element->new('JUNK'))
	} or return(0);
    not eval { Astro::VO::VOTable::VOTABLE->new(\0) } or return(0);
    not eval { Astro::VO::VOTable::VOTABLE->new([]) } or return(0);

    #--------------------------------------------------------------------------

    # Return success.
    return(1);

}

sub test_get_ID()
{

    my($votable);

    # Read ID from a new VOTABLE.
    $votable = Astro::VO::VOTable::VOTABLE->new or return(0);
    $votable->setAttribute('ID', 'test');
    $votable->get_ID eq 'test' or return(0);

    # Read ID from a empty VOTABLE.
    $votable->removeAttribute('ID');
    not defined($votable->get_ID) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_ID()
{

    my($votable);

    # Set then read ID from a new VOTABLE.
    $votable = Astro::VO::VOTable::VOTABLE->new or return(0);
    $votable->set_ID('test');
    $votable->get_ID eq 'test' or return(0);

    # Read ID from a empty VOTABLE.
    $votable->set_ID('');
    $votable->get_ID eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_version()
{

    my($votable);

    # Read version from a new VOTABLE.
    $votable = Astro::VO::VOTable::VOTABLE->new or return(0);
    $votable->setAttribute('version', 'test');
    $votable->get_version eq 'test' or return(0);

    # Read version from a empty VOTABLE.
    $votable->removeAttribute('version');
    not defined($votable->get_version) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_version()
{

    my($votable);

    # Set then read version from a new VOTABLE.
    $votable = Astro::VO::VOTable::VOTABLE->new or return(0);
    $votable->set_version('test');
    $votable->get_version eq 'test' or return(0);

    # Read version from a empty VOTABLE.
    $votable->set_version('');
    $votable->get_version eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_DESCRIPTION()
{
    my($votable);
    my($description);

    $votable = Astro::VO::VOTable::VOTABLE->new or return(0);
    $description = Astro::VO::VOTable::DESCRIPTION->new or return(0);
    $votable->appendChild($description);
    $description->isSameNode($votable->get_DESCRIPTION(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_DESCRIPTION()
{
    my($votable);
    my($description);

    $votable = Astro::VO::VOTable::VOTABLE->new or return(0);
    $description = Astro::VO::VOTable::DESCRIPTION->new or return(0);
    $votable->set_DESCRIPTION($description);
    $description->isSameNode($votable->get_DESCRIPTION(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_DEFINITIONS()
{
    my($votable);
    my($definitions);

    $votable = Astro::VO::VOTable::VOTABLE->new or return(0);
    $definitions = Astro::VO::VOTable::DEFINITIONS->new or return(0);
    $votable->appendChild($definitions);
    $definitions->isSameNode($votable->get_DEFINITIONS(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_DEFINITIONS()
{
    my($votable);
    my($definitions);

    $votable = Astro::VO::VOTable::VOTABLE->new or return(0);
    $definitions = Astro::VO::VOTable::DEFINITIONS->new or return(0);
    $votable->set_DEFINITIONS($definitions);
    $definitions->isSameNode($votable->get_DEFINITIONS(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_INFO()
{
    my($votable);
    my($info);

    $votable = Astro::VO::VOTable::VOTABLE->new or return(0);
    $info = Astro::VO::VOTable::INFO->new or return(0);
    $votable->appendChild($info);
    $info->isSameNode($votable->get_INFO(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_INFO()
{
    my($votable);
    my($info);

    $votable = Astro::VO::VOTable::VOTABLE->new or return(0);
    $info = Astro::VO::VOTable::INFO->new or return(0);
    $votable->set_INFO($info);
    $info->isSameNode($votable->get_INFO(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_RESOURCE()
{
    my($votable);
    my($resource);

    $votable = Astro::VO::VOTable::VOTABLE->new or return(0);
    $resource = Astro::VO::VOTable::RESOURCE->new or return(0);
    $votable->appendChild($resource);
    $resource->isSameNode($votable->get_RESOURCE(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_RESOURCE()
{
    my($votable);
    my($resource);

    $votable = Astro::VO::VOTable::VOTABLE->new or return(0);
    $resource = Astro::VO::VOTable::RESOURCE->new or return(0);
    $votable->set_RESOURCE($resource);
    $resource->isSameNode($votable->get_RESOURCE(0)) or return(0);

    # All tests passed.
    return(1);

}
