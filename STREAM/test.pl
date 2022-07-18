# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 16 };
use Astro::VO::VOTable::STREAM;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

#########################

# External modules

# Subroutine prototypes
sub test_new();
sub test_get_type();
sub test_set_type();
sub test_get_href();
sub test_set_href();
sub test_get_actuate();
sub test_set_actuate();
sub test_get_encoding();
sub test_set_encoding();
sub test_get_expires();
sub test_set_expires();
sub test_get_rights();
sub test_set_rights();
sub test_get();
sub test_set();

#########################

# Test.
ok(test_new, 1);
ok(test_get_type, 1);
ok(test_set_type, 1);
ok(test_get_href, 1);
ok(test_set_href, 1);
ok(test_get_actuate, 1);
ok(test_set_actuate, 1);
ok(test_get_encoding, 1);
ok(test_set_encoding, 1);
ok(test_get_expires, 1);
ok(test_set_expires, 1);
ok(test_get_rights, 1);
ok(test_set_rights, 1);
ok(test_get, 1);
ok(test_set, 1);

#########################

sub test_new()
{

    # Test the plain-vanilla constructor.
    Astro::VO::VOTable::STREAM->new or return(0);

    # Try creating from a XML::LibXML::Element object.
    Astro::VO::VOTable::STREAM->new(XML::LibXML::Element->new('STREAM')) or return(0);

    # Make sure the constructor fails when a bad reference is passed
    # in.
    not eval { Astro::VO::VOTable::STREAM->new(XML::LibXML::Element->new('JUNK')) }
      or return(0);
    not eval { Astro::VO::VOTable::STREAM->new(\0) } or return(0);
    not eval { Astro::VO::VOTable::STREAM->new([]) } or return(0);

    #--------------------------------------------------------------------------

    # Return success.
    return(1);

}

sub test_get_type()
{
    my($stream);
    my($type);
    my(@valids) = qw(locator other);

    # Create the object.
    $stream = Astro::VO::VOTable::STREAM->new or return(0);

    # Try each of the valid values.
    foreach $type (@valids) {
	$stream->setAttribute('type', $type);
	$stream->get_type eq $type or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_set_type()
{
    my($stream);
    my($type);
    my(@valids) = qw(locator other);

    # Create the object.
    $stream = Astro::VO::VOTable::STREAM->new or return(0);

    # Try each of the valid values.
    foreach $type (@valids) {
	$stream->set_type($type);
	$stream->get_type eq $type or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_get_href()
{
    my($stream);

    # Create the object.
    $stream = Astro::VO::VOTable::STREAM->new or return(0);

    # Try each of the valid hrefs.
    $stream->setAttribute('href', 'http://heasarc.gsfc.nasa.gov');
    $stream->get_href eq 'http://heasarc.gsfc.nasa.gov' or return(0);

    # All tests passed.
    return(1);

}

sub test_set_href()
{
    my($stream);

    # Create the object.
    $stream = Astro::VO::VOTable::STREAM->new or return(0);

    # Try each of the valid hrefs.
    $stream->set_href('http://www.nasa.gov');
    $stream->get_href eq 'http://www.nasa.gov' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_actuate()
{
    my($stream);
    my($actuate);
    my(@valids) = qw(onLoad onRequest other none);

    # Create the object.
    $stream = Astro::VO::VOTable::STREAM->new or return(0);

    # Try each of the valid values.
    foreach $actuate (@valids) {
	$stream->setAttribute('actuate', $actuate);
	$stream->get_actuate eq $actuate or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_set_actuate()
{
    my($stream);
    my($actuate);
    my(@valids) = qw(onLoad onRequest other none);

    # Create the object.
    $stream = Astro::VO::VOTable::STREAM->new or return(0);

    # Try each of the valid values.
    foreach $actuate (@valids) {
	$stream->set_actuate($actuate);
	$stream->get_actuate eq $actuate or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_get_encoding()
{
    my($stream);
    my($encoding);
    my(@valids) = qw(gzip base64 dynamic none);

    # Create the object.
    $stream = Astro::VO::VOTable::STREAM->new or return(0);

    # Try each of the valid values.
    foreach $encoding (@valids) {
	$stream->setAttribute('encoding', $encoding);
	$stream->get_encoding eq $encoding or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_set_encoding()
{
    my($stream);
    my($encoding);
    my(@valids) = qw(gzip base64 dynamic none);

    # Create the object.
    $stream = Astro::VO::VOTable::STREAM->new or return(0);

    # Try each of the valid values.
    foreach $encoding (@valids) {
	$stream->set_encoding($encoding);
	$stream->get_encoding eq $encoding or return(0);
    }

    # All tests passed.
    return(1);

}

sub test_get_expires()
{
    my($stream);

    # Create the object.
    $stream = Astro::VO::VOTable::STREAM->new or return(0);

    # Try each of the valid expiress.
    $stream->setAttribute('expires', 'Today');
    $stream->get_expires eq 'Today' or return(0);

    # All tests passed.
    return(1);

}

sub test_set_expires()
{
    my($stream);

    # Create the object.
    $stream = Astro::VO::VOTable::STREAM->new or return(0);

    # Try each of the valid expiress.
    $stream->set_expires('Today');
    $stream->get_expires eq 'Today' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_rights()
{
    my($stream);

    # Create the object.
    $stream = Astro::VO::VOTable::STREAM->new or return(0);

    # Try each of the valid rightss.
    $stream->setAttribute('rights', 'none');
    $stream->get_rights eq 'none' or return(0);

    # All tests passed.
    return(1);

}

sub test_set_rights()
{
    my($stream);

    # Create the object.
    $stream = Astro::VO::VOTable::STREAM->new or return(0);

    # Try each of the valid rightss.
    $stream->set_rights('none');
    $stream->get_rights eq 'none' or return(0);

    # All tests passed.
    return(1);

}

sub test_get()
{
    my($stream);

    # Create the object.
    $stream = Astro::VO::VOTable::STREAM->new or return(0);

    # Add then read the text.
    $stream->appendChild(XML::LibXML::Text->new('This is a test.'));
    $stream->get eq 'This is a test.' or return(0);

    # All tests passed.
    return(1);

}

sub test_set()
{
    my($stream);

    # Create the object.
    $stream = Astro::VO::VOTable::STREAM->new or return(0);

    # Add then read the text.
    $stream->set('This is a test.');
    $stream->get eq 'This is a test.' or return(0);

    # All tests passed.
    return(1);

}
