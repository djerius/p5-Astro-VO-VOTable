# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 20 };
use Astro::VO::VOTable::LINK;
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
sub test_get_content_role();
sub test_set_content_role();
sub test_get_content_type();
sub test_set_content_type();
sub test_get_title();
sub test_set_title();
sub test_get_value();
sub test_set_value();
sub test_get_href();
sub test_set_href();
sub test_get_gref();
sub test_set_gref();
sub test_get_action();
sub test_set_action();
sub test_get();
sub test_set();

#########################

# Test.
ok(test_new, 1);
ok(test_get_ID, 1);
ok(test_set_ID, 1);
ok(test_get_content_role, 1);
ok(test_set_content_role, 1);
ok(test_get_content_type, 1);
ok(test_set_content_type, 1);
ok(test_get_title, 1);
ok(test_set_title, 1);
ok(test_get_value, 1);
ok(test_set_value, 1);
ok(test_get_href, 1);
ok(test_set_href, 1);
ok(test_get_gref, 1);
ok(test_set_gref, 1);
ok(test_get_action, 1);
ok(test_set_action, 1);
ok(test_get, 1);
ok(test_set, 1);

#########################

sub test_new()
{

    # Test the plain-vanilla constructor.
    Astro::VO::VOTable::LINK->new or return(0);

    # Try creating from a XML::LibXML::Element object.
    Astro::VO::VOTable::LINK->new(XML::LibXML::Element->new('LINK')) or return(0);

    # Make sure the constructor fails when a bad reference is passed
    # in.
    not eval { Astro::VO::VOTable::LINK->new(XML::LibXML::Element->new('JUNK')) }
      or return(0);
    not eval { Astro::VO::VOTable::LINK->new(\0) } or return(0);
    not eval { Astro::VO::VOTable::LINK->new([]) } or return(0);

    #--------------------------------------------------------------------------

    # Return success.
    return(1);

}

sub test_get_ID()
{

    my($link);

    # Read ID from a new LINK.
    $link = Astro::VO::VOTable::LINK->new or return(0);
    $link->setAttribute('ID', 'test');
    $link->get_ID eq 'test' or return(0);

    # Read ID from a empty LINK.
    $link->removeAttribute('ID');
    not defined($link->get_ID) or return(0);

    # All tests passed.
    return(1);

}

sub test_set_ID()
{

    my($link);

    # Set then read ID from a new LINK.
    $link = Astro::VO::VOTable::LINK->new or return(0);
    $link->set_ID('test');
    $link->get_ID eq 'test' or return(0);

    # Read ID from a empty LINK.
    $link->set_ID('');
    $link->get_ID eq '' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_content_role()
{
    my($link);
    my($content_role);
    my(@valids) = qw(query hints doc);

    # Create the object.
    $link = Astro::VO::VOTable::LINK->new or return(0);

    # Try each of the valid values.
    foreach $content_role (@valids) {
	$link->setAttribute('content-role', $content_role);
	$link->get_content_role eq $content_role or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_set_content_role()
{
    my($link);
    my($content_role);
    my(@valids) = qw(query hints doc);

    # Create the object.
    $link = Astro::VO::VOTable::LINK->new or return(0);

    # Try each of the valid values.
    foreach $content_role (@valids) {
	$link->set_content_role($content_role);
	$link->get_content_role eq $content_role or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_get_content_type()
{
    my($link);

    # Create the object.
    $link = Astro::VO::VOTable::LINK->new or return(0);

    # Try each of the valid values.
    $link->setAttribute('content-type', 'text/html');
    $link->get_content_type eq 'text/html' or return(0);

    # All tests passed.
    return(1);

}

sub test_set_content_type()
{
    my($link);

    # Create the object.
    $link = Astro::VO::VOTable::LINK->new or return(0);

    # Try each of the valid values.
    $link->set_content_type('text/html');
    $link->get_content_type eq 'text/html' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_title()
{
    my($link);

    # Create the object.
    $link = Astro::VO::VOTable::LINK->new or return(0);

    # Try each of the valid values.
    $link->setAttribute('title', 'This is a test!');
    $link->get_title eq 'This is a test!' or return(0);

    # All tests passed.
    return(1);

}

sub test_set_title()
{
    my($link);

    # Create the object.
    $link = Astro::VO::VOTable::LINK->new or return(0);

    # Try each of the valid values.
    $link->set_title('This is also a test!');
    $link->get_title eq 'This is also a test!' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_value()
{
    my($link);

    # Create the object.
    $link = Astro::VO::VOTable::LINK->new or return(0);

    # Try each of the valid values.
    $link->setAttribute('value', 'This is a test!');
    $link->get_value eq 'This is a test!' or return(0);

    # All tests passed.
    return(1);

}

sub test_set_value()
{
    my($link);

    # Create the object.
    $link = Astro::VO::VOTable::LINK->new or return(0);

    # Try each of the valid values.
    $link->set_value('This is also a test!');
    $link->get_value eq 'This is also a test!' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_href()
{
    my($link);

    # Create the object.
    $link = Astro::VO::VOTable::LINK->new or return(0);

    # Try each of the valid hrefs.
    $link->setAttribute('href', 'http://heasarc.gsfc.nasa.gov');
    $link->get_href eq 'http://heasarc.gsfc.nasa.gov' or return(0);

    # All tests passed.
    return(1);

}

sub test_set_href()
{
    my($link);

    # Create the object.
    $link = Astro::VO::VOTable::LINK->new or return(0);

    # Try each of the valid hrefs.
    $link->set_href('http://www.nasa.gov');
    $link->get_href eq 'http://www.nasa.gov' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_gref()
{
    my($link);

    # Create the object.
    $link = Astro::VO::VOTable::LINK->new or return(0);

    # Try each of the valid grefs.
    $link->setAttribute('gref', 'http://heasarc.gsfc.nasa.gov');
    $link->get_gref eq 'http://heasarc.gsfc.nasa.gov' or return(0);

    # All tests passed.
    return(1);

}

sub test_set_gref()
{
    my($link);

    # Create the object.
    $link = Astro::VO::VOTable::LINK->new or return(0);

    # Try each of the valid grefs.
    $link->set_gref('http://www.nasa.gov');
    $link->get_gref eq 'http://www.nasa.gov' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_action()
{
    my($link);

    # Create the object.
    $link = Astro::VO::VOTable::LINK->new or return(0);

    # Try each of the valid actions.
    $link->setAttribute('action', 'none');
    $link->get_action eq 'none' or return(0);

    # All tests passed.
    return(1);

}

sub test_set_action()
{
    my($link);

    # Create the object.
    $link = Astro::VO::VOTable::LINK->new or return(0);

    # Try each of the valid actions.
    $link->set_action('also none');
    $link->get_action eq 'also none' or return(0);

    # All tests passed.
    return(1);

}

sub test_get()
{
    my($link);

    # Create the object.
    $link = Astro::VO::VOTable::LINK->new or return(0);

    # Add then read the text.
    $link->appendChild(XML::LibXML::Text->new('This is a test.'));
    $link->get eq 'This is a test.' or return(0);

    # All tests passed.
    return(1);

}

sub test_set()
{
    my($link);

    # Create the object.
    $link = Astro::VO::VOTable::LINK->new or return(0);

    # Add then read the text.
    $link->set('This is a test.');
    $link->get eq 'This is a test.' or return(0);

    # All tests passed.
    return(1);

}
