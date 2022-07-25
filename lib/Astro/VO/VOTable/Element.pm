package Astro::VO::VOTable::Element;

# ABSTRACT: Generic VOTable element class

use strict;
use warnings;

our $VERSION = '1.1';

use XML::LibXML;

# XML::LibXML::Element is in an inner package
use parent -norequire => 'XML::LibXML::Element';

use namespace::clean;

use constant ELEMENT_NODE => 1;
use constant TEXT_NODE => 3;
use constant CDATA_SECTION_NODE => 4;

# Define the default attribute and child element lists as empty.
our @valid_attribute_names = ();
our @valid_child_element_names = ();

#******************************************************************************

# Method definitions

#------------------------------------------------------------------------------

sub _croak {
    shift;
    require Carp;
    goto \&Carp::croak;
}

=method new($arg)

Create and return a new Astro::VO::VOTable::Element object, or an
object derived from it. Return undef if an error occurs. This method
dynamically determines the tag name (and thus the class name) for the
new element from the class name used when the constructor is invoked,
and blesses the new object appropriately. For example, the TD element
class inherits this method. When called at run time, the constructor
determines that the method is called for the class
Astro::VO::VOTable::TD, and blesses the new object into that class. If
$arg is supplied, and is a XML::LibXML::Element object, that object is
used to create the Astro::VO::VOTable::Element object (just by
reblessing).

=cut

sub new()
{
    my($class, $arg) = @_;

    # Extract the tag name from the class name.
    my $tag_name = ($class =~ /^.+::(.+)/)[0] or return(undef);

    # Check to see if an argument (a XML::LibXML::Element) object was
    # provided. If so, use it to create the new
    # Astro::VO::VOTable::Element object. Otherwise, create one from
    # scratch.
    my $self;
    
    if ($arg) {

        # Make sure a XML::LibXML::Element object was provided.
        ref($arg) eq 'XML::LibXML::Element' or return(undef);

        # Make sure the element name is the same as the tag name.
        $tag_name eq $arg->nodeName or return(undef);

        # Use the supplied object as the new object.
        $self = $arg;

    } else {

        # Create the new element.
        $self = XML::LibXML::Element->new($tag_name) or return(undef);

    }

    return bless $self => $class;
}

#------------------------------------------------------------------------------

=method get()

Return all of the text (including the contents of CDATA sections) from
within this element as a single string. Return an empty string if
there is no text. Return undef if an error occurs. The string is
constructed by concatenating the text from each child text/CDATA node.
This method is only intended for use by elements which contain PCDATA
content and/or CDATA sections. It should also work for mixed-model
elements (i.e. with PCDATA/CDATA and child elements), but those types
of elements should normally be avoided. Character entities are NOT
converted to entity references. Text which was ingested as a character
entity reference, or as part of a CDATA section, is therefore returned
by the get() method in its parsed form. For example, text containing
the string '&amp;' returns as '&'; a CDATA section containing '&' also
returns as '&'.

=cut

sub get() { $_[0]->textContent; }

#------------------------------------------------------------------------------

=method set($str)

Set the text content of the element to the specified string. Throw an
exception if an error occurs. This method is only intended for use by
elements which contain PCDATA content. It should also work for
mixed-model elements (i.e. with PCDATA and child elements), but those
types of elements should normally be avoided. Note that the existing
text content of the element is deleted first. Character entities
should _not_ be replaced with the corresponding entity references
before this method is called. For example, to put a '&' into the
element, call set('&'). If you call set('&amp;'), you will get() back
the string '&amp;' (which is probably a good thing).

=cut

sub set()
{
    my($self, $str) = @_;

    # Empty the element.
    $self->empty;

    # Create a text node for the new text and add it.
    my $text = XML::LibXML::Text->new($str)
        or $self->_croak('Unable to create new XML::LibXML::Text object!');
    $self->appendChild($text);
}

#------------------------------------------------------------------------------

=method empty()

Empty the text content of the element (all text and CDATA). Throw an
exception if an error occurs. This method is only intended for use by
elements which contain PCDATA content. It should also work for
mixed-model elements (i.e. with PCDATA and child elements), but those
types of elements should normally be avoided.

=cut

sub empty()
{
    my($self) = @_;

    # Remove and delete the existing text child nodes.
    foreach my $node ($self->getChildNodes) {
        next if ($node->nodeType != TEXT_NODE and
                 $node->nodeType != CDATA_SECTION_NODE);
        $node->unbindNode; # Probably memory leak here.
    }
}

#------------------------------------------------------------------------------

=method get_valid_attribute_names()

Return a list of the names of attributes valid for this element. Throw
an exception if an error occurs. The list of valid attributes is
stored in the package variable @valid_attribute_names. This list is
empty for Astro::VO::VOTable::Element, but must be set as needed for
any subclasses. Subclasses with no attributes must define
@valid_attribute_names as an empty list.

=cut

sub get_valid_attribute_names()
{
    my($self) = @_;
    my($var) = ref($self) . "::valid_attribute_names";
    no strict 'refs'; ## no critic
    return(@$var);
}

#------------------------------------------------------------------------------

=method get_valid_child_element_names()

Return a list of the names of child elements valid for this
element. Throw an exception if an error occurs. The list of valid
child elements is stored in the package variable
@valid_child_element_names. This list is empty for
Astro::VO::VOTable::Element, but should be set as needed for any
subclasses. Subclasses with no child elements must define
@valid_child_element_names as an empty list.

=cut

sub get_valid_child_element_names()
{
    my($self) = @_;
    my($var) = ref($self) . "::valid_child_element_names";
    no strict 'refs'; ## no critic
    return(@$var);
}

#------------------------------------------------------------------------------

sub AUTOLOAD()
{

    # Keep arguments in @_ to make it easier to use goto().

    #--------------------------------------------------------------------------

    # Local variables

    # $AUTOLOAD is a package variable that will contain the
    # fully-qualified name of the method being requested.
    our($AUTOLOAD);

    # Name of requested attribute or element.
    my($name);

    #--------------------------------------------------------------------------

    # Bounce back if DESTROY has been requested.
    return if $AUTOLOAD =~ /::DESTROY$/;

    # Extract the method type ('get', 'set', 'append', or 'remove'),
    # and the intended target (the name of an attribute or child
    # element). Note that in all cases, attributes are checked before
    # elements.
    no strict 'refs'; ## no critic

    # "get" accessors
    if ($AUTOLOAD =~ /::get_(\w+)$/) {
        ($name = $1) =~ s/_/-/g;
        if (grep(/^$name$/, $_[0]->get_valid_attribute_names)) {
            *{$AUTOLOAD} = sub { $_[0]->getAttribute($name); };
        } elsif (grep(/^$name$/, $_[0]->get_valid_child_element_names)) {
            *{$AUTOLOAD} = sub {
                my(@elements);
                if (defined($_[1])) {
                    @elements = $_[0]->getChildrenByTagName($name)->
                        get_node($_[1] + 1) // ();
                } else {
                    @elements = $_[0]->getChildrenByTagName($name);
                }
                bless ( $_ => "Astro::VO::VOTable::${name}" ) for
                  @elements;
                if (wantarray) {
                    return(@elements);
                } else {
                    return($elements[0]);
                }
            };
        }

    # "set" accessors
    } elsif ($AUTOLOAD =~ /::set_(\w+)$/) {
        ($name = $1) =~ s/_/-/g;
        if (grep(/^$name$/, $_[0]->get_valid_attribute_names)) {
            *{$AUTOLOAD} = sub { $_[0]->setAttribute($name, $_[1]); };
        } elsif (grep(/^$name$/, $_[0]->get_valid_child_element_names)) {
            *{$AUTOLOAD} = sub { $_[0]->_set_child_elements(@_[1 .. $#_]); };
        }

    # "append" accessors
    } elsif ($AUTOLOAD =~ /::append_(\w+)$/) {
        ($name = $1) =~ s/_/-/g;
        if (grep(/^$name$/, $_[0]->get_valid_child_element_names)) {
            *{$AUTOLOAD} = sub { $_[0]->_append_child_elements(@_[1 .. $#_]);};
        }

    # "remove" accessors
    } elsif ($AUTOLOAD =~ /::remove_(\w+)$/) {
        ($name = $1) =~ s/_/-/g;
        if (grep(/^$name$/, $_[0]->get_valid_attribute_names)) {
            *{$AUTOLOAD} = sub { $_[0]->removeAttribute($name); };
        } elsif (grep(/^$name$/, $_[0]->get_valid_child_element_names)) {
            *{$AUTOLOAD} = sub { $_[0]->_remove_child_elements($name); };
        }

    # Bad method requested.
    } else {
        __PACKAGE__->_croak("Bad AUTOLOAD ($AUTOLOAD)!");
    }

    # Invoke the constructed method.
    goto &{$AUTOLOAD};

}

#------------------------------------------------------------------------------

=imethod _set_child_elements(@elements)

(Internal method) Set the child elements of a single type of the
current element to the specified elements. All items in @elements are
assumed to be XML::LibXML::Element-derived objects with the same tag
name. Existing elements with the same tag name are removed prior to
adding the new elements. Throw an exception if an error occurs.

=cut

sub _set_child_elements()
{
    my($self, @elements) = @_;

    # Fetch the tag name of the new elements.
    my $tag_name = $elements[0]->nodeName;

    # Remove all existing elements of this name.
    $self->_remove_child_elements($tag_name);

    # Add the new elements to the current object.
    $self->_append_child_elements(@elements);
}

#------------------------------------------------------------------------------

=imethod _append_child_elements(@elements)

(Internal method) Append the specified elements to the current
element. All items in @elements are assumed to be
XML::LibXML::Element-derived objects. Throw an exception if an error
occurs.

=cut
  
sub _append_child_elements()
{
    my($self, @elements) = @_;
    # Append the elements to the current object.
    foreach my $element (@elements) {
        $self->appendChild($element);
    }
}

#------------------------------------------------------------------------------

=imethod _remove_child_elements($tag_name)

(Internal method) Remove all child elements with the specified tag
name. Throw an exception if an error occurs.

=cut

sub _remove_child_elements()
{
    my($self, $tag_name) = @_;
    # Remove and delete each element with this tag name.
    foreach my $node ($self->childNodes) {
        next if $node->nodeType != ELEMENT_NODE;
        next if $node->nodeName ne $tag_name;
        $node->unbindNode; # Possible memory leak here.
    }
}

1;

# COPYRIGHT

__END__

=pod

=head1 SYNOPSIS

use Astro::VO::VOTable::Element;

=head1 DESCRIPTION

This class implements a generic interface to VOTable elements. This
class inherits from XML::LibXML::Element. All VOTable element classes
should inherit from this class to ensure uniform functionality.

This class implements much of the functionality of each element by
providing generic code that is customized at run time for each
element. For example, a single AUTOLOAD method is used to implement
the accessors (get_*, set_*, remove_*) for all attributes, and the
accessors (get_*, set_*, append_*, remove_*) for child elements,
greatly decreasing the amount of code required to implement an element
class. Methods created in this fashion are cached by inserting them
into the appropriate namespace, so the AUTOLOAD mechanism is only
invoked once for any method.

This class was designed to be subclassed, and should rarely (if ever)
be used in its base form.

There are a few warnings that must be kept in mind when using the
inherited methods, especially when adding a class for a new element:

=over 4

=item

VOTable element tag names should always be completely in upper case.

=item

VOTable element attribute names should always be completely in lower
case. The only exception is the 'ID' attribute.

=item

VOTable attribute names which contain hyphens (-) as a word separator
must map the hyphens to underscores (_) when calling the corresponding
accessors. For example, to call the 'get' method for the
'content-type' attribute, call get_content_type, not get_content-type
(which is an invalid name for a subroutine in Perl).

=back

=head2 Methods

=head3 AUTOLOAD(@args)

This method is used to handle calls to accessors for attributes and
child elements. The package variable $AUTOLOAD is checked for the
requested method name, and the appropriate calls to other methods are
made to execute the desired action. For example, if the attribute
accessor get_ID() is called, the AUTOLOAD() method is invoked when the
method is not explicitly found. The $AUTOLOAD variable is parsed to
get the desired attribute name, and getAttribute() is called to get
the value of the ID attribute. This approach allows the addition of
new attributes and child elements to element classes without adding
new method code. The allowed attributes for an element class must be
listed in a package variable in the class called
@valid_attribute_names, and valid names for child elements must be
listed in @valid_child_element_names. Note that if better performance
is required, derived classes can explicitly implement any desired
accessor methods, which will automatically override the corresponding
methods based on the AUTOLOAD() mechanism. If a 'get' accessor is
called for an attribute, return the value of the attribute (the value
will be 'undef' if the attribute is not set). If a 'set' or 'remove'
accessor is called for an attribute, do so. If a 'get' accessor is
called for a child element, return a (possibly empty) list containing
the objects for the child elements of that type. If one or more
indices are provided to the element get call, return the child
elements at those positions. If a 'set' accessor is called, remove and
delete any existing child elements of the specified type, and append
the new children provided in the argument list. If a 'append' accessor
is called, append the new children provided in the argument list. If a
'remove' accessor is called, remove and delete all child elements of
the specified type. Throw an exception if an error occurs, such as the
use of an invalid attribute or child element name. Methods are
dynamically created and inserted into the appropriate symbol table so
that AUTOLOAD is only invoked once for any given method.

=head1 WARNINGS

=over 4

=item

The VOTable format defined by the DTD is not currently strictly
enforced. Attributes are not validated before setting.

=item

When nodes are removed with the unbindNode method, they are attached
to a hidden document fragment by LibXML, and therefore are NOT removed
from memory. I am trying to find a way to get around this problem,
since it can lead to horrendous memory leaks.

=back

=head1 SEE ALSO

XML::LibXML::Element

=cut
