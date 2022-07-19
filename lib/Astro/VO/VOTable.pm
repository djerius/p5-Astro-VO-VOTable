package Astro::VO::VOTable;

# ABSTRACT: VOTable document manipulation package

use strict;
use diagnostics;
use warnings;

our $VERSION = '1.1';

# load all of the Astro::VO::VOTable modules:
use Astro::VO::VOTable::INFO;
use Astro::VO::VOTable::Element;
use Astro::VO::VOTable::Document;
use Astro::VO::VOTable::TABLEDATA;
use Astro::VO::VOTable::DEFINITIONS;
use Astro::VO::VOTable::RESOURCE;
use Astro::VO::VOTable::GROUP;
use Astro::VO::VOTable::FIELD;
use Astro::VO::VOTable::VOTABLE;
use Astro::VO::VOTable::FITS;
use Astro::VO::VOTable::TD;
use Astro::VO::VOTable::TR;
use Astro::VO::VOTable::LINK;
use Astro::VO::VOTable::DATA;
use Astro::VO::VOTable::MAX;
use Astro::VO::VOTable::STREAM;
use Astro::VO::VOTable::BINARY;
use Astro::VO::VOTable::COOSYS;
use Astro::VO::VOTable::DESCRIPTION;
use Astro::VO::VOTable::TABLE;
use Astro::VO::VOTable::MIN;
use Astro::VO::VOTable::VALUES;
use Astro::VO::VOTable::OPTION;
use Astro::VO::VOTable::PARAM;

# COPYRIGHT

1;

__END__

=head1 SYNOPSIS

  # load all of the modules in the Astro::VO::VOTable namespace
  use Astro::VO::VOTable;

=head1 DESCRIPTION

The VOTABLE package is a set of Perl modules which provide an
object-oriented interface to VOTABLE-formatted XML files. The software
is built atop the Perl L<XML::LibXML> module, which is a Perl interface
to the C-based libxml2 XML parser.

The VOTABLE software provides a class for each valid element defined
in the VOTABLE DTD.

The programs in the 'examples' subdirectory illustrate the use of the
modules to read a VOTABLE document and access its parts, and the
construction of a VOTABLE document from scratch, and printing it out.

=head2 Outline

Each VOTABLE element has a class for it. All of the element classes
inherit from the L<Astro::VO::VOTable::Element> class, which itself inherits from
the L<XML::LibXML::Element> class. Therefore, if you need functionality
that is not provided by the VOTable methods, you can probably get the
needed functionality by calling the L<XML::LibXML::Element> methods. In a similar vein,
the L<AO::VOTable::Document> class inherits from L<XML::LibXML::Document>q.

Each element class provides get, set, remove, and append accessors for
each child element, and get, set, and remove accessors for each
attribute. The code throws an exception if you use an invalid child
element or invalid attribute.

The set and append methods for child elements all take list
arguments. For elements with individual child elements, the list
should contain a single element; the code does NOT enforce this
restriction at this point, so be careful.

The get methods for child elements all return lists, even when only
one element is expected. Therefore, the get accessor results should be
indexed to get the desired element.

All get, set, append, and remove methods are implemented by the
AUTOLOAD method in L<Astro::VO::Table::Element>, greatly decreasing the amount of code
needed to support new elements.

=head1 SEE ALSO

XML::LibXML
