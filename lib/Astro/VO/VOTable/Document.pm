package Astro::VO::VOTable::Document;

# ABSTRACT: VOTable document class

use strict;
use warnings;

our $VERSION = '1.1';

use XML::LibXML;
# XML::LibXML::Document is in an inner package
use parent -norequire => 'XML::LibXML::Document';

use Carp;

use namespace::clean;

use Astro::VO::VOTable::VOTABLE;

# Default version of XML.
use constant DEFAULT_VERSION => '1.0';

# Default document encoding.
use constant DEFAULT_ENCODING => 'UTF-8';

my($parser);

BEGIN
{
    # Create the class parser.
    $parser = XML::LibXML->new
        or croak('Unable to create XML::LibXML parser!');

}

=method new(%args)

Create and return a new Astro::VO::VOTable::Document object,
containing a single, empty VOTABLE element. Return undef if an error
occurs. The optional %args argument may be used to pass named
parameters to the constructor, in name => value format. The 'version'
argument may be used to set the XML version in the XML declaration
(the default version is '1.0'). The 'encoding' argument may be used to
set the document encoding (the default encoding is 'UTF-8'). The
'standalone' argument may be used to set the value of the standalone
attribute (the default is to not define the 'standalone'
attribute). Note that the Astro::VO::VOTable::* code itself makes no
use of any of the attributes of the XML declaration.

=cut

sub new()
{
    my($class, %args) = @_;

    # Supply defaults for missing arguments.
    my $version = defined($args{'version'}) ? $args{'version'} : DEFAULT_VERSION;
    my $encoding = defined($args{'encoding'}) ? $args{'encoding'} :
        DEFAULT_ENCODING;
    my $standalone = exists($args{'standalone'}) ? $args{'standalone'} : undef;

    # Create the object with the appropriate arguments.
    my $self = XML::LibXML::Document->new($version, $encoding) or return(undef);

    # Bless the new object into this class.
    bless $self => $class;

    # If the 'standalone' attribute was specified, set it.
    $self->set_standalone($standalone);

    # Create and add an empty VOTABLE element.
    my $votable = Astro::VO::VOTable::VOTABLE->new() or return(undef);
    $self->setDocumentElement($votable);

    # Return a reference to the new object.
    return($self);
}

#------------------------------------------------------------------------------

=method new_from_string($string)

Create and return a new Astro::VO::VOTable::Document object by parsing
the specified XML string. Return undef if an error occurs.

=cut

sub new_from_string()
{
    my($class, $xml) = @_;

    # Parse the XML to create a XML::LibXML::Document object. Use eval
    # to catch exceptions that are raised if the XML is not valid.
    my $self = eval { $parser->parse_string($xml) } or return(undef);
    return bless $self => $class;
}

#------------------------------------------------------------------------------

=method new_from_file($path)

Create and return a new Astro::VO::VOTable::Document object using the
contents of the specified file. Return undef if an error occurs.

=cut

sub new_from_file()
{
    my($class, $path) = @_;
    # Parse the XML file to create a XML::LibXML::Document object.
    my $self = eval { $parser->parse_file($path) } or return(undef);

    return bless $self => $class;
}

#------------------------------------------------------------------------------

=method get_version

Return the value of the 'version' attribute of the XML declaration for
this object. The default value is '1.0'. Note that the counterpart
set_version method is not supplied since the 'version' attribute
must be specified when the document is created.

=cut

sub get_version() { $_[0]->getVersion }

#------------------------------------------------------------------------------

=method get_encoding

Return the value of the 'encoding' attribute of the XML declaration
for this object. The default value is 'UTF-8'.

=cut

sub get_encoding() { $_[0]->encoding }

=method set_encoding($encoding)

Set the value of the 'version' attribute of the XML declaration for
this object to the specified value. The default value is 'UTF-8'.

=cut

sub set_encoding() { $_[0]->setEncoding($_[1]) }

#------------------------------------------------------------------------------

=method get_standalone

Return the value of the 'standalone' attribute of the XML declaration
for this object. The valid values are 'yes', 'no', and undef (if not
specified).

=cut

sub get_standalone() {
    my($standalone) = $_[0]->standalone;
    $standalone = (undef, 'no', 'yes')[$standalone + 1];
    return($standalone);
}

=method set_standalone($standalone)

Set the value of the 'attribute' attribute of the XML declaration for
this object to the specified value. The valid values are 'yes', 'no',
and undef (if not specified). Raise an exception if an error occurs.

=cut

sub set_standalone() {
    my($self, $standalone) = @_;
    if (defined($standalone)) {
        if ($standalone eq 'no') {
            $standalone = 0;
        } elsif ($standalone eq 'yes') {
            $standalone = 1;
        } else {
            croak("Bad standalone ($standalone)!");
        }
    } else {
        $standalone = -1;
    }
    $self->setStandalone($standalone);
}

#------------------------------------------------------------------------------

=method get_VOTABLE

Return a L<Astro::VO::VOTable::VOTABLE> object for the VOTABLE element at
the root of this Document. Return undef if no VOTABLE element is
found, or an error occurs.

=cut

sub get_VOTABLE()
{
    my($self) = @_;

    # Find the document root element.
    my $votable = $self->documentElement or return(undef);

    # If not one already, convert it to a Astro::VO::VOTable::VOTABLE
    # object.
    $votable = Astro::VO::VOTable::VOTABLE->new($votable)
      unless $votable->isa('Astro::VO::VOTable::VOTABLE');

    return $votable;
}

#------------------------------------------------------------------------------

=method set_VOTABLE($votable)

Set the VOTABLE element for this Document using the supplied
L<Astro::VO::VOTable::VOTABLE> object.

=cut

sub set_VOTABLE()
{
    my($self, $votable) = @_;
    $self->setDocumentElement($votable);

}

#******************************************************************************

1;

# COPYRIGHT

__END__

=pod

=for stopwords
validator

=head1 SYNOPSIS

use Astro::VO::VOTable::Document;

$doc = Astro::VO::VOTable::Document->new(%args);
$doc = Astro::VO::VOTable::Document->new_from_string($string);
$doc = Astro::VO::VOTable::Document->new_from_file($path);

$version = $doc->get_version;
$encoding = $doc->get_encoding;
$doc->set_encoding($encoding);
$standalone = $doc->get_standalone;
$doc->set_standalone($standalone);

$votable = $doc->get_VOTABLE;
$doc->set_VOTABLE($votable);

=head1 DESCRIPTION

This class implements an interface to VOTable documents. This class
inherits from XML::LibXML:Document.

Upon initial loading of this module, the BEGIN subroutine creates a
XML::LibXML parser object for global use by the class.

In general, the Astro::VO::VOTable::* classes perform only the amount
of input validation required for proper execution. For example, the
Astro::VO::VOTable::Document constructors below do not check the
actual values of the 'version', 'encoding', and 'standalone'
attributes (other than to check that they are defined), since those
values are not used by this code in any way - they are used only by
the XML processor.

Similarly, the Astro::VO::VOTable::* classes perform only rudimentary
checks to ensure that elements are in the order described by the
VOTable specification. It is easy for the user to get things out of
order if he is not careful, especially if the inherited methods from
XML::LibXML::* objects are used. It is probably best, for efficiency
and QA purposes, that any VOTable documents produced using this code
are validated by a separate XML validator before they are used by
other programs.

=head1 SEE ALSO

XML::LibXML::Document

=cut
