# DATA.pm

# $Id: DATA.pm,v 1.1.1.25 2003/11/14 15:38:11 elwinter Exp $

# NOTE: All internal subroutine names start with a leading underscore
# (_) character, and assume that their inputs are valid.

#******************************************************************************

=pod

=head1 NAME

Astro::VO::VOTable::DATA - VOTable DATA element class

=head1 SYNOPSIS

use Astro::VO::VOTable::DATA;

=head1 DESCRIPTION

This class implements an interface to VOTable DATA elements. This
class inherits from Astro::VO::VOTable::Element, and therefore all of
the methods from that class are available to this class. This file
will only document the methods specific to this class.

=head2 Methods

=head3 get_array()

Return a reference to a 2-D array containing the data contents of the
table. Return undef if an error occurs.

=head3 get_row($rownum)

Return row $rownum of the data, as an array of values. The array
elements should be interpreted in the same order as the FIELD elements
in the enclosing TABLE element. Return undef if an error occurs.

=head3 get_cell($i, $j)

Return column $j of row $i of the data, as a string. Return undef if
an error occurs. Note that row and field indices start at 0. NOTE:
This method is slow, and should only be used in situations where speed
is not a concern.

=head3 get_num_rows()

Return the number of rows in the table. Return undef if an error
occurs.

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

$Id: DATA.pm,v 1.1.1.25 2003/11/14 15:38:11 elwinter Exp $

=cut

#******************************************************************************

# Revision history

# $Log: DATA.pm,v $
# Revision 1.1.1.25  2003/11/14 15:38:11  elwinter
# Switched to Astro::VO::VOTable:: namespace.
#
# Revision 1.1.1.24  2003/10/31 13:52:19  elwinter
# Overhauled in preparation for redesign.
#
# Revision 1.1.1.23  2003/05/31 21:37:17  elwinter
# Rearranged the code and updated documentation.
#
# Revision 1.1.1.22  2003/05/31 21:28:09  elwinter
# Added overriding set_FITS() method.
#
# Revision 1.1.1.21  2003/05/31 21:24:19  elwinter
# Added overriding set_BINARY() method.
#
# Revision 1.1.1.20  2003/05/31 21:20:22  elwinter
# Added overriding set_TABLEDATA() method.
#
# Revision 1.1.1.19  2003/05/16 19:35:58  elwinter
# Invalidated append_TABLEDATA(), append_BINARY(), and append_FITS() methods.
#
# Revision 1.1.1.18  2003/05/16 18:17:17  elwinter
# Added overriding get_FITS() method.
#
# Revision 1.1.1.17  2003/05/16 18:13:43  elwinter
# Added overriding get_BINARY() method.
#
# Revision 1.1.1.16  2003/05/16 16:46:19  elwinter
# Added overriding get_TABLEDATA() method.
#
# Revision 1.1.1.15  2003/04/07 17:25:51  elwinter
# Updated documentation.
#
# Revision 1.1.1.14  2003/03/20 16:09:37  elwinter
# Added get_array() method.
#
# Revision 1.1.1.13  2003/03/14 13:32:33  elwinter
# Added get_cell() method.
#
# Revision 1.1.1.12  2003/03/12 12:41:44  elwinter
# Overhauled to use XML::LibXML.
#
# Revision 1.1.1.11  2002/11/19 13:53:28  elwinter
# Moved all element accessors to VOTable::Element class.
#
# Revision 1.1.1.10  2002/11/17 16:29:51  elwinter
# Added code for get_valid_child_element_names.
#
# Revision 1.1.1.9  2002/11/14 17:12:02  elwinter
# Moved new to Element.
#
# Revision 1.1.1.8  2002/11/14 16:37:19  elwinter
# Moved toString and new_from_xmldom to Element.
#
# Revision 1.1.1.7  2002/11/13 19:04:01  elwinter
# Moved all accessor (get/set/remove methods to VOTable::Element AUTOLOAD.
#
# Revision 1.1.1.6  2002/11/12 15:28:33  elwinter
# Added toString method.
#
# Revision 1.1.1.5  2002/10/25 18:30:48  elwinter
# Changed required Perl version to 5.6.0.
#
# Revision 1.1.1.4  2002/10/25 18:30:22  elwinter
# Changed required Perl version to 5.6.0.
#
# Revision 1.1.1.3  2002/09/11  17:50:00  elwinter
# Added get_num_rows() method.
#
# Revision 1.1.1.2  2002/09/11  17:01:03  elwinter
# Added get_row() method.
#
# Revision 1.1.1.1  2002/09/11  16:26:59  elwinter
# Placeholder for new branch.
#
# Revision 1.1  2002/09/11  15:27:33  elwinter
# Initial revision
#

#******************************************************************************

# Begin the package definition.
package Astro::VO::VOTable::DATA;

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
use Astro::VO::VOTable::BINARY;
use Astro::VO::VOTable::FITS;
use Astro::VO::VOTable::TABLEDATA;

#******************************************************************************

# Class constants

#******************************************************************************

# Class variables

our(@valid_attribute_names) = ();
our(@valid_child_element_names) = qw(TABLEDATA BINARY FITS);

#******************************************************************************

# Method definitions

#******************************************************************************

sub get_array()
{

    # Save arguments.
    my($self) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Array of results.
    my($array);

    #--------------------------------------------------------------------------

    # Extract the data based on the underlying data format.
    if ($self->get_TABLEDATA(0)) {
	$array = $self->get_TABLEDATA(0)->get_array;
    } else {
	return(undef);
    }

    # Return the array.
    return($array);

}

#******************************************************************************

sub get_row()
{

    # Save arguments.
    my($self, $rownum) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Row of results.
    my(@row);

    #--------------------------------------------------------------------------

    # Extract the row based on the underlying data format.
    if ($self->get_TABLEDATA(0)) {
	@row = $self->get_TABLEDATA(0)->get_row($rownum);
    } else {
	return(undef);
    }

    # Return the row.
    return(@row);

}

#******************************************************************************

sub get_cell()
{

    # Save arguments.
    my($self, $i, $j) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Cell value.
    my($cell);

    #--------------------------------------------------------------------------

    # Extract the cell based on the underlying data format.
    if ($self->get_TABLEDATA(0)) {
	$cell = $self->get_TABLEDATA(0)->get_cell($i, $j);
    } else {
	return(undef);
    }

    # Return the cell.
    return($cell);

}

#******************************************************************************

sub get_num_rows()
{

    # Save arguments.
    my($self) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Number of rows in table.
    my($num_rows);

    #--------------------------------------------------------------------------

    # Extract the row count based on the underlying data format.
    if ($self->get_TABLEDATA(0)) {
	$num_rows = $self->get_TABLEDATA(0)->get_num_rows;
    } else {
	return(undef);
    }

    # Return row count.
    return($num_rows);

}

#******************************************************************************
1;
__END__
