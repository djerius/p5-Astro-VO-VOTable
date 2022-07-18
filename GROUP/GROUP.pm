# GROUP.pm

# $Id: GROUP.pm,v 1.1 2004/02/19 18:23:04 elwinter Exp $

# NOTE: All internal subroutine names start with a leading underscore
# (_) character, and assume that their inputs are valid.

#******************************************************************************

=pod

=head1 NAME

Astro::VO::VOTable::GROUP - VOTable GROUP element class

=head1 SYNOPSIS

use Astro::VO::VOTable::FIELD;

=head1 DESCRIPTION

This class implements an interface to VOTable GROUP elements. This
class inherits from Astro::VO::VOTable::Element, and therefore all of
the methods from that class are available to this class. This file
will only document the methods specific to this class.

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

$Id: GROUP.pm,v 1.1 2004/02/19 18:23:04 elwinter Exp $

=cut

#******************************************************************************

# Revision history

# $Log: GROUP.pm,v $
# Revision 1.1  2004/02/19 18:23:04  elwinter
# Initial revision
#

#******************************************************************************

# Begin the package definition.
package Astro::VO::VOTable::GROUP;

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
our($VERSION) = 2.0;

#******************************************************************************

# Specify external modules to use.

# Standard modules

# Third-party modules

# Project modules
use Astro::VO::VOTable::DESCRIPTION;
use Astro::VO::VOTable::FIELD;
use Astro::VO::VOTable::PARAM;

#******************************************************************************

# Class constants

#******************************************************************************

# Class variables

our(@valid_attribute_names) = qw(ID name ref ucd utype);
our(@valid_child_element_names) = qw(DESCRIPTION FIELD PARAM);

#******************************************************************************

# Method definitions

#******************************************************************************
1;
__END__
