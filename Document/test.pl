# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 11 };
use Astro::VO::VOTable::Document;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

#########################

# External modules
use English;

# Subroutine prototypes
sub test_new();
sub test_new_from_string();
sub test_new_from_file();
sub test_get_version();
sub test_get_encoding();
sub test_set_encoding();
sub test_get_standalone();
sub test_set_standalone();
sub test_get_VOTABLE();
sub test_set_VOTABLE();

#########################

# Test the constructor.
ok(test_new, 1);
ok(test_new_from_string, 1);
ok(test_new_from_file, 1);
ok(test_get_version, 1);
ok(test_get_encoding, 1);
ok(test_set_encoding, 1);
ok(test_get_standalone, 1);
ok(test_set_standalone, 1);
ok(test_get_VOTABLE, 1);
ok(test_set_VOTABLE, 1);

#########################

sub test_new()
{

    # Make sure it works when it should.
    Astro::VO::VOTable::Document->new() or return(0);
    Astro::VO::VOTable::Document->new('version' => '1.0') or return(0);
    Astro::VO::VOTable::Document->new('encoding' => 'UTF-8') or return(0);
    Astro::VO::VOTable::Document->new('standalone' => 'yes') or return(0);
    Astro::VO::VOTable::Document->new('standalone' => 'no') or return(0);
    Astro::VO::VOTable::Document->new('standalone' => undef) or return(0);
    Astro::VO::VOTable::Document->new('version' => '1.0',
				      'encoding' => 'UTF-8') or return(0);
    Astro::VO::VOTable::Document->new('encoding' => 'UTF-8',
 				      'version' => '1.0') or return(0);
    Astro::VO::VOTable::Document->new('version' => '1.0',
 				      'encoding' => 'UTF-8',
 				      'standalone' => 'yes') or return(0);

    # Make sure it does not work when it should not (TBD).

    # All tests passed.
    return(1);

}

sub test_new_from_string()
{
    my($xml);

    # Make sure it works when it should.
    $xml = <<_EOS_
<?xml version="1.0"?>
<VOTABLE/>
_EOS_
    ;
    Astro::VO::VOTable::Document->new_from_string($xml) or return(0);

    $xml = <<_EOS_
<?xml version="1.0" encoding="UTF-8"?>
<VOTABLE/>
_EOS_
    ;
    Astro::VO::VOTable::Document->new_from_string($xml) or return(0);

    $xml = <<_EOS_
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<VOTABLE/>
_EOS_
    ;
    Astro::VO::VOTable::Document->new_from_string($xml) or return(0);

    $xml = '<VOTABLE/>';
    Astro::VO::VOTable::Document->new_from_string($xml) or return(0);

    # Make sure it does not work when it should not.
    $xml = '<VOTABLE>';
    not Astro::VO::VOTable::Document->new_from_string($xml) or return(0);

    # All tests passed.
    return(1);

}

sub test_new_from_file()
{
    my($xml);
    my($document);
    my($testfile) = 'test.xml';

    # Make sure it works when it should.

    # Create the test file.
    $xml = <<_EOS_
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<VOTABLE/>
_EOS_
    ;
    open(TEST, ">$testfile") or return(0);
    print TEST $xml;
    close(TEST) or return(0);

    # Parse the XML into a document object.
    Astro::VO::VOTable::Document->new_from_file($testfile) or return(0);

    # Delete the test file.
    unlink($testfile) or return(0);

    # Make sure it does not work when it should not.

    # Create the test file.
    $xml = <<_EOS_
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<VOTABLE>
_EOS_
    ;
    open(TEST, ">$testfile") or return(0);
    print TEST $xml;
    close(TEST) or return(0);

    # Parse the XML into a document object.
    not Astro::VO::VOTable::Document->new_from_file($testfile) or return(0);

    # Delete the test file.
    unlink($testfile) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_version()
{
    my($doc);

    # Make sure it works when it should.
    $doc = Astro::VO::VOTable::Document->new() or return(0);
    $doc->get_version eq '1.0' or return(0);
    $doc = Astro::VO::VOTable::Document->new('version' => '1.0') or return(0);
    $doc->get_version eq '1.0' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_encoding()
{
    my($doc);

    # Make sure it works when it should.
    $doc = Astro::VO::VOTable::Document->new() or return(0);
    $doc->get_encoding eq 'UTF-8' or return(0);
    $doc = Astro::VO::VOTable::Document->new('encoding' => 'UTF-8')
	or return(0);
    $doc->get_encoding eq 'UTF-8' or return(0);

    # All tests passed.
    return(1);

}

sub test_set_encoding()
{
    my($doc);

    # Make sure it works when it should.
    $doc = Astro::VO::VOTable::Document->new() or return(0);
    $doc->set_encoding('UTF-8');
    $doc->get_encoding eq 'UTF-8' or return(0);

    # All tests passed.
    return(1);

}

sub test_get_standalone()
{
    my($doc);

    # Make sure it works when it should.
    $doc = Astro::VO::VOTable::Document->new() or return(0);
    not defined($doc->get_standalone) or return(0);
    $doc = Astro::VO::VOTable::Document->new('standalone' => 'yes')
	or return(0);
    $doc->get_standalone eq 'yes' or return(0);
    $doc = Astro::VO::VOTable::Document->new('standalone' => 'no')
	or return(0);
    $doc->get_standalone eq 'no' or return(0);

    # All tests passed.
    return(1);

}

sub test_set_standalone()
{
    my($doc);

    # Make sure it works when it should.
    $doc = Astro::VO::VOTable::Document->new() or return(0);
    $doc->set_standalone('yes');
    $doc->get_standalone eq 'yes' or return(0);
    $doc->set_standalone('no');
    $doc->get_standalone eq 'no' or return(0);
    $doc->set_standalone(undef);
    not defined($doc->get_standalone) or return(0);

    # All tests passed.
    return(1);

}

sub test_get_VOTABLE()
{

    # Local variables

    # Object for test document.
    my($document);

    # XML for test document.
    my($xml) = '<VOTABLE ID="test_ID"/>';

    # Object for test VOTABLE element.
    my($votable);

    #--------------------------------------------------------------------------

    # Create a document.
    $document = Astro::VO::VOTable::Document->new_from_string($xml)
	or return(0);

    # Extract the VOTABLE element object.
    $votable = $document->get_VOTABLE or return(0);
    $votable->isa('Astro::VO::VOTable::VOTABLE') or return(0);
    $votable->get_ID eq 'test_ID' or return(0);

    # All tests passed.
    return(1);

}

sub test_set_VOTABLE()
{
    my($document);
    my($votable);

    # Create the document, then get a reference to its VOTABLE
    # element.
    $document = Astro::VO::VOTable::Document->new or return(0);

    # Set the VOTABLE element of the Document.
    $votable = Astro::VO::VOTable::VOTABLE->new or return(0);
    $votable->set_ID('test');
    $document->set_VOTABLE($votable);
    $votable = $document->get_VOTABLE or return(0);
    $votable->get_ID eq 'test' or return(0);

    # All tests passed.
    return(1);

}
