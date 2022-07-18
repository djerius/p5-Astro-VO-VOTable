# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 18 };
use Astro::VO::VOTable::GROUP;
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
sub test_get_ref();
sub test_set_ref();
sub test_get_name();
sub test_set_name();
sub test_get_ucd();
sub test_set_ucd();
sub test_get_utype();
sub test_set_utype();
sub test_get_DESCRIPTION();
sub test_set_DESCRIPTION();
sub test_get_FIELD();
sub test_set_FIELD();
sub test_get_PARAM();
sub test_set_PARAM();

#########################

# Test.
ok(test_new);
ok(test_get_ID);
ok(test_set_ID);
ok(test_get_ref);
ok(test_set_ref);
ok(test_get_name);
ok(test_set_name);
ok(test_get_ucd);
ok(test_set_ucd);
ok(test_get_utype);
ok(test_set_utype);
ok(test_get_DESCRIPTION);
ok(test_set_DESCRIPTION);
ok(test_get_FIELD);
ok(test_set_FIELD);
ok(test_get_PARAM);
ok(test_set_PARAM);

#########################

sub test_new()
{

    # Test the plain-vanilla constructor.
    Astro::VO::VOTable::GROUP->new or return(0);

    # Try creating from a XML::LibXML::Element object.
    Astro::VO::VOTable::GROUP->new(XML::LibXML::Element->new('GROUP'))
	or return(0);

    # Make sure the constructor fails when a bad reference is passed
    # in.
    not eval {
	Astro::VO::VOTable::GROUP->new(XML::LibXML::Element->new('JUNK'))
	} or return(0);
    not eval { Astro::VO::VOTable::GROUP->new(\0) } or return(0);
    not eval { Astro::VO::VOTable::GROUP->new([]) } or return(0);

    #--------------------------------------------------------------------------

    # Return success.
    return(1);

}

sub test_get_ID()
{

    my($group);

    # Read ID from a new GROUP.
    $group = Astro::VO::VOTable::GROUP->new or return(0);
    $group->setAttribute('ID', 'test');
    $group->get_ID eq 'test' or return(0);

    # Read ID from a empty GROUP.
    $group->removeAttribute('ID');
    not defined($group->get_ID) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_ID()
{

    my($group);

    # Set then read ID from a new GROUP.
    $group = Astro::VO::VOTable::GROUP->new or return(0);
    $group->set_ID('test');
    $group->get_ID eq 'test' or return(0);

    # Read ID from a empty GROUP.
    $group->set_ID('');
    $group->get_ID eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_ref()
{

    my($group);

    # Read ref from a new GROUP.
    $group = Astro::VO::VOTable::GROUP->new or return(0);
    $group->setAttribute('ref', 'test');
    $group->get_ref eq 'test' or return(0);

    # Read ref from a empty GROUP.
    $group->removeAttribute('ref');
    not defined($group->get_ref) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_ref()
{

    my($group);

    # Set then read ref from a new GROUP.
    $group = Astro::VO::VOTable::GROUP->new or return(0);
    $group->set_ref('test');
    $group->get_ref eq 'test' or return(0);

    # Read ref from a empty GROUP.
    $group->set_ref('');
    $group->get_ref eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_name()
{

    my($group);

    # Read name from a new GROUP.
    $group = Astro::VO::VOTable::GROUP->new or return(0);
    $group->setAttribute('name', 'test');
    $group->get_name eq 'test' or return(0);

    # Read name from a empty GROUP.
    $group->removeAttribute('name');
    not defined($group->get_name) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_name()
{

    my($group);

    # Set then read name from a new GROUP.
    $group = Astro::VO::VOTable::GROUP->new or return(0);
    $group->set_name('test');
    $group->get_name eq 'test' or return(0);

    # Read name from a empty GROUP.
    $group->set_name('');
    $group->get_name eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_ucd()
{

    my($group);

    # Read ucd from a new GROUP.
    $group = Astro::VO::VOTable::GROUP->new or return(0);
    $group->setAttribute('ucd', 'test');
    $group->get_ucd eq 'test' or return(0);

    # Read ucd from a empty GROUP.
    $group->removeAttribute('ucd');
    not defined($group->get_ucd) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_ucd()
{

    my($group);

    # Set then read ucd from a new GROUP.
    $group = Astro::VO::VOTable::GROUP->new or return(0);
    $group->set_ucd('test');
    $group->get_ucd eq 'test' or return(0);

    # Read ucd from a empty GROUP.
    $group->set_ucd('');
    $group->get_ucd eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_utype()
{

    my($group);

    # Read utype from a new GROUP.
    $group = Astro::VO::VOTable::GROUP->new or return(0);
    $group->setAttribute('utype', 'test');
    $group->get_utype eq 'test' or return(0);

    # Read utype from a empty GROUP.
    $group->removeAttribute('utype');
    not defined($group->get_utype) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_utype()
{

    my($group);

    # Set then read utype from a new GROUP.
    $group = Astro::VO::VOTable::GROUP->new or return(0);
    $group->set_utype('test');
    $group->get_utype eq 'test' or return(0);

    # Read utype from a empty GROUP.
    $group->set_utype('');
    $group->get_utype eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_DESCRIPTION()
{
    my($group);
    my($description);

    $group = Astro::VO::VOTable::GROUP->new or return(0);
    $description = Astro::VO::VOTable::DESCRIPTION->new or return(0);
    $group->appendChild($description);
    $description->isSameNode($group->get_DESCRIPTION(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_DESCRIPTION()
{
    my($group);
    my($description);

    $group = Astro::VO::VOTable::GROUP->new or return(0);
    $description = Astro::VO::VOTable::DESCRIPTION->new or return(0);
    $group->set_DESCRIPTION($description);
    $description->isSameNode($group->get_DESCRIPTION(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_FIELD()
{
    my($group);
    my($field);

    $group = Astro::VO::VOTable::GROUP->new or return(0);
    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $group->appendChild($field);
    $field->isSameNode($group->get_FIELD(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_FIELD()
{
    my($group);
    my($field);

    $group = Astro::VO::VOTable::GROUP->new or return(0);
    $field = Astro::VO::VOTable::FIELD->new or return(0);
    $group->set_FIELD($field);
    $field->isSameNode($group->get_FIELD(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_PARAM()
{
    my($group);
    my($param);

    $group = Astro::VO::VOTable::GROUP->new or return(0);
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $group->appendChild($param);
    $param->isSameNode($group->get_PARAM(0)) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_PARAM()
{
    my($group);
    my($param);

    $group = Astro::VO::VOTable::GROUP->new or return(0);
    $param = Astro::VO::VOTable::PARAM->new or return(0);
    $group->set_PARAM($param);
    $param->isSameNode($group->get_PARAM(0)) or return(0);

    # All tests passed.
    return(1);

}
