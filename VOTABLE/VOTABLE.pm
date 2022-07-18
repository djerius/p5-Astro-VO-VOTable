# VOTABLE.pm

# $Id: VOTABLE.pm,v 1.1.1.16 2003/11/14 15:38:11 elwinter Exp $

# NOTE: All internal subroutine names start with a leading underscore
# (_) character, and assume that their inputs are valid.

#******************************************************************************

=pod

=head1 NAME

Astro::VO::VOTable::VOTABLE - VOTable VOTABLE element class

=head1 SYNOPSIS

use Astro::VO::VOTable::VOTABLE;

=head1 DESCRIPTION

This class implements an interface to VOTable VOTABLE elements. This
class inherits from VOTable::Element, and therefore all of the methods
from that class are available to this class. This file will only
document the methods specific to this class.

=head2 Methods

=head1 WARNINGS

=over 4

=item

None.

=back

=head1 SEE ALSO

=over 4

=item

Astro::VO::VOTable::Element

=back

=head1 AUTHOR

Eric Winter, NASA GSFC (Eric.L.Winter.1@gsfc.nasa.gov)

=head1 VERSION

$Id: VOTABLE.pm,v 1.1.1.16 2003/11/14 15:38:11 elwinter Exp $

=cut

#******************************************************************************

# Revision history

# $Log: VOTABLE.pm,v $
# Revision 1.1.1.16  2003/11/14 15:38:11  elwinter
# Switched to Astro::VO::VOTable:: namespace.
#
# Revision 1.1.1.15  2003/10/31 16:20:25  elwinter
# Overhauled in preparation for redesign.
#
# Revision 1.1.1.14  2003/05/16 19:48:49  elwinter
# Invalidated append_DESCRIPTION() and append_DEFINITIONS() methods.
#
# Revision 1.1.1.13  2003/05/16 13:36:03  elwinter
# Added overriding get_DEFINITIONS() method.
#
# Revision 1.1.1.12  2003/05/16 13:25:53  elwinter
# Added overriding get_DESCRIPTION() method.
#
# Revision 1.1.1.11  2003/04/09 16:25:00  elwinter
# Changed VERSION to 1.0.
#
# Revision 1.1.1.10  2003/04/07 17:29:52  elwinter
# Updated documentation.
#
# Revision 1.1.1.9  2003/03/12 12:41:44  elwinter
# Overhauled to use XML::LibXML.
#
# Revision 1.1.1.8  2002/11/19 13:53:28  elwinter
# Moved all element accessors to VOTable::Element class.
#
# Revision 1.1.1.7  2002/11/17 16:29:51  elwinter
# Added code for get_valid_child_element_names.
#
# Revision 1.1.1.6  2002/11/17 16:05:32  elwinter
# Added code for get_valid_attribute_names.
#
# Revision 1.1.1.5  2002/11/14 17:12:02  elwinter
# Moved new to Element.
#
# Revision 1.1.1.4  2002/11/14 16:37:19  elwinter
# Moved toString and new_from_xmldom to Element.
#
# Revision 1.1.1.3  2002/11/13 19:04:01  elwinter
# Moved all accessor (get/set/remove methods to VOTable::Element AUTOLOAD.
#
# Revision 1.1.1.2  2002/11/12 15:30:11  elwinter
# Added toString method.
#
# Revision 1.1.1.1  2002/10/25 18:30:48  elwinter
# Changed required Perl version to 5.6.0.
#
# Revision 1.1  2002/09/11  16:01:07  elwinter
# Initial revision
#

#******************************************************************************

# Begin the package definition.
package Astro::VO::VOTable::VOTABLE;

#******************************************************************************

# Compiler pragmas.
use strict;
use diagnostics;
use warnings;

#******************************************************************************

# Set up the inheritance mechanism.
use Astro::VO::VOTable::Element;
our(@ISA) = qw(Astro::VO::VOTable::Element);

# Module version.
our($VERSION) = 1.1;

#******************************************************************************

# Specify external modules to use.

# Standard modules

# Third-party modules

# Project modules
use Astro::VO::VOTable::RESOURCE;
use Astro::VO::VOTable::DEFINITIONS;
use Astro::VO::VOTable::DESCRIPTION;
use Astro::VO::VOTable::INFO;

#******************************************************************************

# Class constants

#******************************************************************************

# Class variables

our(@valid_attribute_names) = qw(ID version);
our(@valid_child_element_names) = qw(DESCRIPTION DEFINITIONS INFO RESOURCE);

#******************************************************************************

# Method definitions

#******************************************************************************
1;
__END__
