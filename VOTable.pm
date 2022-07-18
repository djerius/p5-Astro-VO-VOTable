# VOTable.pm

# $Id: VOTable.pm,v 1.1.1.2 2003/11/13 21:31:24 elwinter Exp $

# NOTE: All internal subroutine names start with a leading underscore
# (_) character, and assume that their inputs are valid.

#******************************************************************************

=pod

=head1 NAME

Astro::VO::VOTable - VOTable document manipulation package

=head1 SYNOPSIS

use Astro::VO::VOTable;

=head1 DESCRIPTION

This code can be used to manipulate VOTable-format XML documents. See
the subsidiary module documentation for details.

=head1 WARNINGS

=over 4

=item

None.

=back

=head1 SEE ALSO

=over 4

=item

XML::LibXML

=back

=head1 AUTHOR

Eric Winter, NASA GSFC (Eric.L.Winter.1@gsfc.nasa.gov)

=head1 VERSION

$Id: VOTable.pm,v 1.1.1.2 2003/11/13 21:31:24 elwinter Exp $

=cut

#******************************************************************************

# Revision history

# $Log: VOTable.pm,v $
# Revision 1.1.1.2  2003/11/13 21:31:24  elwinter
# Changed name to Astro::VO::VOTable.
#
# Revision 1.1.1.1  2002/10/25 18:30:48  elwinter
# Changed required Perl version to 5.6.0.
#
# Revision 1.1  2002/09/06  19:28:31  elwinter
# Initial revision
#

#******************************************************************************

# Begin the package definition.
package Astro::VO::VOTable;

#******************************************************************************

# Compiler pragmas.
use strict;
use diagnostics;
use warnings;

#******************************************************************************

# Module version.
our($VERSION) = '1.1';

#******************************************************************************

# Specify external modules to use.

# Standard modules.

# Third-party modules.

# Project modules.

#******************************************************************************

# Class constants.

#******************************************************************************

# Class variables.

#******************************************************************************

# Local subroutines.

#******************************************************************************

# Method definitions

#******************************************************************************
1;
__END__
