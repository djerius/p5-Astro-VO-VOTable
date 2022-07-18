# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 22 };
use Astro::VO::VOTable::RESOURCE;
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
sub test_get_type();
sub test_set_type();
sub test_get_DESCRIPTION();
sub test_set_DESCRIPTION();
sub test_get_INFO();
sub test_set_INFO();
sub test_get_COOSYS();
sub test_set_COOSYS();
sub test_get_PARAM();
sub test_set_PARAM();
sub test_get_LINK();
sub test_set_LINK();
sub test_get_TABLE();
sub test_set_TABLE();
sub test_get_RESOURCE();
sub test_set_RESOURCE();

#########################

# Test.
ok(test_new, 1);
ok(test_get_ID, 1);
ok(test_set_ID, 1);
ok(test_get_name, 1);
ok(test_set_name, 1);
ok(test_get_type, 1);
ok(test_set_type, 1);
ok(test_get_DESCRIPTION, 1);
ok(test_set_DESCRIPTION, 1);
ok(test_get_INFO, 1);
ok(test_set_INFO, 1);
ok(test_get_COOSYS, 1);
ok(test_set_COOSYS, 1);
ok(test_get_PARAM, 1);
ok(test_set_PARAM, 1);
ok(test_get_LINK, 1);
ok(test_set_LINK, 1);
ok(test_get_TABLE, 1);
ok(test_set_TABLE, 1);
ok(test_get_RESOURCE, 1);
ok(test_set_RESOURCE, 1);

#########################

sub test_new()
{

    # Test the plain-vanilla constructor.
    Astro::VO::VOTable::RESOURCE->new or return(0);

    # Try creating from a XML::LibXML::Element object.
    Astro::VO::VOTable::RESOURCE->new(XML::LibXML::Element->new('RESOURCE'))
	or return(0);

    # Make sure the constructor fails when a bad reference is passed
    # in.
    not eval { Astro::VO::VOTable::RESOURCE->
		   new(XML::LibXML::Element->new('JUNK')) } or return(0);
    not eval { Astro::VO::VOTable::RESOURCE->new(\0) } or return(0);
    not eval { Astro::VO::VOTable::RESOURCE->new([]) } or return(0);

    #--------------------------------------------------------------------------

    # Return success.
    return(1);

}

sub test_get_ID()
{

    my($resource);

    # Read ID from a new RESOURCE.
    $resource = Astro::VO::VOTable::RESOURCE->new or return(0);
    $resource->setAttribute('ID', 'test');
    $resource->get_ID eq 'test' or return(0);

    # Read ID from a empty RESOURCE.
    $resource->removeAttribute('ID');
    not defined($resource->get_ID) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_ID()
{

    my($resource);

    # Set then read ID from a new RESOURCE.
    $resource = Astro::VO::VOTable::RESOURCE->new or return(0);
    $resource->set_ID('test');
    $resource->get_ID eq 'test' or return(0);

    # Read ID from a empty RESOURCE.
    $resource->set_ID('');
    $resource->get_ID eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_name()
{

    my($resource);

    # Read name from a new RESOURCE.
    $resource = Astro::VO::VOTable::RESOURCE->new or return(0);
    $resource->setAttribute('name', 'test');
    $resource->get_name eq 'test' or return(0);

    # Read name from a empty RESOURCE.
    $resource->removeAttribute('name');
    not defined($resource->get_name) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_name()
{

    my($resource);

    # Set then read name from a new RESOURCE.
    $resource = Astro::VO::VOTable::RESOURCE->new or return(0);
    $resource->set_name('test');
    $resource->get_name eq 'test' or return(0);

    # Read name from a empty RESOURCE.
    $resource->set_name('');
    $resource->get_name eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_type()
{
    my($resource);
    my($type);
    my(@valids) = qw(query hints doc);

    # Create the object.
    $resource = Astro::VO::VOTable::RESOURCE->new or return(0);

    # Try each of the valid values.
    foreach $type (@valids) {
	$resource->setAttribute('type', $type);
	$resource->get_type eq $type or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_set_type()
{
    my($resource);
    my($type);
    my(@valids) = qw(query hints doc);

    # Create the object.
    $resource = Astro::VO::VOTable::RESOURCE->new or return(0);

    # Try each of the valid values.
    foreach $type (@valids) {
	$resource->set_type($type);
	$resource->get_type eq $type or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_get_DESCRIPTION()
{
    my($table);
    my($description);

    $table = Astro::VO::VOTable::TABLE->new or return(0);
    $description = Astro::VO::VOTable::DESCRIPTION->new or return(0);
    $table->appendChild($description);
    $description->isSameNode($table->get_DESCRIPTION(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_DESCRIPTION()
{
    my($table);
    my($description);

    $table = Astro::VO::VOTable::TABLE->new or return(0);
    $description = Astro::VO::VOTable::DESCRIPTION->new or return(0);
    $table->set_DESCRIPTION($description);
    $description->isSameNode($table->get_DESCRIPTION(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_INFO()
{
    my($resource);
    my($info);

    $resource = Astro::VO::VOTable::RESOURCE->new or return(0);
    $info = Astro::VO::VOTable::INFO->new or return(0);
    $resource->appendChild($info);
    $info->isSameNode($resource->get_INFO(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_INFO()
{
    my($resource);
    my($info);

    $resource = Astro::VO::VOTable::RESOURCE->new or return(0);
    $info = Astro::VO::VOTable::INFO->new or return(0);
    $resource->set_INFO($info);
    $info->isSameNode($resource->get_INFO(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_COOSYS()
{
    my($resource);
    my($coosys);

    $resource = Astro::VO::VOTable::RESOURCE->new or return(0);
    $coosys = Astro::VO::VOTable::COOSYS->new or return(0);
    $resource->appendChild($coosys);
    $coosys->isSameNode($resource->get_COOSYS(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_COOSYS()
{
    my($resource);
    my($coosys);

    $resource = Astro::VO::VOTable::RESOURCE->new or return(0);
    $coosys = Astro::VO::VOTable::COOSYS->new or return(0);
    $resource->set_COOSYS($coosys);
    $coosys->isSameNode($resource->get_COOSYS(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_PARAM()
{
    my($resource);
    my($param);

    $resource = Astro::VO::VOTable::RESOURCE->new or return(0);
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $resource->appendChild($param);
    $param->isSameNode($resource->get_PARAM(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_PARAM()
{
    my($resource);
    my($param);

    $resource = Astro::VO::VOTable::RESOURCE->new or return(0);
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $resource->set_PARAM($param);
    $param->isSameNode($resource->get_PARAM(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_LINK()
{
    my($resource);
    my($link);

    $resource = Astro::VO::VOTable::RESOURCE->new or return(0);
    $link = Astro::VO::VOTable::LINK->new or return(0);
    $resource->appendChild($link);
    $link->isSameNode($resource->get_LINK(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_LINK()
{
    my($resource);
    my($link);

    $resource = Astro::VO::VOTable::RESOURCE->new or return(0);
    $link = Astro::VO::VOTable::LINK->new or return(0);
    $resource->set_LINK($link);
    $link->isSameNode($resource->get_LINK(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_TABLE()
{
    my($resource);
    my($table);

    $resource = Astro::VO::VOTable::RESOURCE->new or return(0);
    $table = Astro::VO::VOTable::TABLE->new or return(0);
    $resource->appendChild($table);
    $table->isSameNode($resource->get_TABLE(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_TABLE()
{
    my($resource);
    my($table);

    $resource = Astro::VO::VOTable::RESOURCE->new or return(0);
    $table = Astro::VO::VOTable::TABLE->new or return(0);
    $resource->set_TABLE($table);
    $table->isSameNode($resource->get_TABLE(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_RESOURCE()
{
    my($resource);
    my($resource2);

    $resource = Astro::VO::VOTable::RESOURCE->new or return(0);
    $resource2 = Astro::VO::VOTable::RESOURCE->new or return(0);
    $resource->appendChild($resource2);
    $resource2->isSameNode($resource->get_RESOURCE(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_RESOURCE()
{
    my($resource);
    my($resource2);

    $resource = Astro::VO::VOTable::RESOURCE->new or return(0);
    $resource2 = Astro::VO::VOTable::RESOURCE->new or return(0);
    $resource->set_RESOURCE($resource2);
    $resource2->isSameNode($resource->get_RESOURCE(0)) or return(0);

    # All tests passed.
    return(1);

}
