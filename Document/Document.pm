# Document.pm

# $Id: Document.pm,v 1.1.1.15 2003/11/14 15:38:11 elwinter Exp $

# NOTE: All internal subroutine names start with a leading underscore
# (_) character, and assume that their inputs are valid.

#******************************************************************************

=pod

=head1 NAME

Astro::VO::VOTable::Document - VOTable document class

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

=head2 Methods

=head3 new(%args)

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

=head3 new_from_string($string)

Create and return a new Astro::VO::VOTable::Document object by parsing
the specified XML string. Return undef if an error occurs.

=head3 new_from_file($path)

Create and return a new Astro::VO::VOTable::Document object using the
contents of the specified file. Return undef if an error occurs.

=head3 get_version

Return the value of the 'version' attribute of the XML declaration for
this object. The default value is '1.0'. Note that the counterpart
set_version method is not supplied since the 'version' attribute
must be specified when the document is created.

=head3 get_encoding

Return the value of the 'encoding' attribute of the XML declaration
for this object. The default value is 'UTF-8'.

=head3 set_encoding($encoding)

Set the value of the 'version' attribute of the XML declaration for
this object to the specified value. The default value is 'UTF-8'.

=head3 get_standalone

Return the value of the 'standalone' attribute of the XML declaration
for this object. The valid values are 'yes', 'no', and undef (if not
specified).

=head3 set_standalone($standalone)

Set the value of the 'attribute' attribute of the XML declaration for
this object to the specified value. The valid values are 'yes', 'no',
and undef (if not specified). Raise an exception if an error occurs.

=head3 get_VOTABLE

Return a Astro::VO::VOTable::VOTABLE object for the VOTABLE element at
the root of this Document. Return undef if no VOTABLE element is
found, or an error occurs.

=head3 set_VOTABLE($votable)

Set the VOTABLE element for this Document using the supplied
Astro::VO::VOTable::VOTABLE object.

=head1 WARNINGS

=over 4

=item

None.

=back

=head1 SEE ALSO

=over 4

=item

XML::LibXML::Document

=back

=head1 AUTHOR

Eric Winter, NASA GSFC (Eric.L.Winter.1@gsfc.nasa.gov)

=head1 VERSION

$Id: Document.pm,v 1.1.1.15 2003/11/14 15:38:11 elwinter Exp $

=cut

#******************************************************************************

# Revision history

# $Log: Document.pm,v $
# Revision 1.1.1.15  2003/11/14 15:38:11  elwinter
# Switched to Astro::VO::VOTable:: namespace.
#
# Revision 1.1.1.14  2003/10/28 15:55:30  elwinter
# Overhaul in preparation for new version.
#
# Revision 1.1.1.13  2003/05/16 13:24:58  elwinter
# Changed to use isa() method.
#
# Revision 1.1.1.12  2003/05/16 11:37:58  elwinter
# Changed get_VOTABLE to use new() rather than bless().
#
# Revision 1.1.1.11  2003/04/09 16:25:00  elwinter
# Changed VERSION to 1.0.
#
# Revision 1.1.1.10  2003/04/07 17:26:41  elwinter
# Updated documentation.
#
# Revision 1.1.1.9  2003/03/12 12:41:44  elwinter
# Overhauled to use XML::LibXML.
#
# Revision 1.1.1.8  2002/12/02 19:07:22  elwinter
# Cleaned up toString method, modified constructors to properly bless children.
#
# Revision 1.1.1.7  2002/12/02 18:49:16  elwinter
# Added toString() method.
#
# Revision 1.1.1.6  2002/11/19 15:13:20  elwinter
# Changed get_votable to get_VOTABLE.
#
# Revision 1.1.1.5  2002/11/14 16:37:19  elwinter
# Moved toString and new_from_xmldom to Element.
#
# Revision 1.1.1.4  2002/11/13 19:04:01  elwinter
# Moved all accessor (get/set/remove methods to VOTable::Element AUTOLOAD.
#
# Revision 1.1.1.3  2002/10/25 18:30:48  elwinter
# Changed required Perl version to 5.6.0.
#
# Revision 1.1.1.2  2002/09/12  17:36:53  elwinter
# Added stub document code to ensure a root VOTABLE element is created.
#
# Revision 1.1.1.1  2002/09/12  17:29:39  elwinter
# Placeholder for new branch.
#
# Revision 1.1  2002/09/11  16:04:04  elwinter
# Initial revision
#

#******************************************************************************

# Begin the package definition.
package Astro::VO::VOTable::Document;

#******************************************************************************

# Compiler pragmas.
use strict;
use diagnostics;
use warnings;

#******************************************************************************

# Set up the inheritance mechanism.
use XML::LibXML;
our(@ISA) = qw(XML::LibXML::Document);

# Module version.
our($VERSION) = 1.1;

#******************************************************************************

# Specify external modules to use.

# Standard modules
use Carp;

# Third-party modules

# Project modules
use Astro::VO::VOTable::VOTABLE;

#******************************************************************************

# Class constants

# Default version of XML.
use constant DEFAULT_VERSION => '1.0';

# Default document encoding.
use constant DEFAULT_ENCODING => 'UTF-8';

#******************************************************************************

# Class variables

# This object is used to perform all parsing.
my($parser);

#******************************************************************************

# Local subroutines.

#******************************************************************************

BEGIN
{
    # Create the class parser.
    $parser = XML::LibXML->new
	or croak('Unable to create XML::LibXML parser!');

}

#******************************************************************************

# Method definitions

#------------------------------------------------------------------------------

sub new()
{

    # Save arguments.
    my($class, %args) = @_;

    #--------------------------------------------------------------------------

    # Local variables

    # Reference to new object.
    my($self);

    # Attributes of new Document.
    my($version, $encoding, $standalone);

    # New VOTABLE element.
    my($votable);

    #--------------------------------------------------------------------------

    # Supply defaults for missing arguments.
    $version = defined($args{'version'}) ? $args{'version'} : DEFAULT_VERSION;
    $encoding = defined($args{'encoding'}) ? $args{'encoding'} :
	DEFAULT_ENCODING;
    $standalone = exists($args{'standalone'}) ? $args{'standalone'} : undef;

    # Create the object with the appropriate arguments.
    $self = XML::LibXML::Document->new($version, $encoding) or return(undef);

    # Bless the new object into this class.
    bless $self => $class;

    # If the 'standalone' attribute was specified, set it.
    $self->set_standalone($standalone);

    # Create and add an empty VOTABLE element.
    $votable = Astro::VO::VOTable::VOTABLE->new() or return(undef);
    $self->setDocumentElement($votable);

    # Return a reference to the new object.
    return($self);

}

#------------------------------------------------------------------------------

sub new_from_string()
{

    # Save arguments.
    my($class, $xml) = @_;

    #--------------------------------------------------------------------------

    # Local variables

    # Reference to new object.
    my($self);

    #--------------------------------------------------------------------------

    # Parse the XML to create a XML::LibXML::Document object. Use eval
    # to catch exceptions that are raised if the XML is not valid.
    $self = eval { $parser->parse_string($xml) } or return(undef);

    # Bless into this class.
    bless $self => $class;

    # Return a reference to the new object.
    return($self);

}

#------------------------------------------------------------------------------

sub new_from_file()
{

    # Save arguments.
    my($class, $path) = @_;

    #--------------------------------------------------------------------------

    # Local variables

    # Reference to new object.
    my($self);

    #--------------------------------------------------------------------------

    # Parse the XML file to create a XML::LibXML::Document object.
    $self = eval { $parser->parse_file($path) } or return(undef);

    # Bless into this class.
    bless $self => $class;

    # Return a reference to the new object.
    return($self);

}

#------------------------------------------------------------------------------

sub get_version() { $_[0]->getVersion }

#------------------------------------------------------------------------------

sub get_encoding() { $_[0]->encoding }
sub set_encoding() { $_[0]->setEncoding($_[1]) }

#------------------------------------------------------------------------------

sub get_standalone() {
    my($standalone) = $_[0]->standalone;
    $standalone = (undef, 'no', 'yes')[$standalone + 1];
    return($standalone);
}

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

sub get_VOTABLE()
{

    # Save arguments.
    my($self) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Astro::VO::VOTable::VOTABLE for VOTABLE element.
    my($votable);

    #--------------------------------------------------------------------------

    # Find the document root element.
    $votable = $self->documentElement or return(undef);

    # If not one already, convert it to a Astro::VO::VOTable::VOTABLE
    # object.
    if (not $votable->isa('Astro::VO::VOTable::VOTABLE')) {
	$votable = Astro::VO::VOTable::VOTABLE->new($votable) or return(undef);
    }

    # Return the VOTABLE element object.
    return($votable);

}

#------------------------------------------------------------------------------

sub set_VOTABLE()
{

    # Save arguments.
    my($self, $votable) = @_;

    #--------------------------------------------------------------------------

    # Set the VOTABLE element.
    $self->setDocumentElement($votable);

}

#******************************************************************************
1;
__END__
