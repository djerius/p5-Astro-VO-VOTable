# TABLE.pm

# $Id: TABLE.pm,v 1.1.1.28 2004/02/11 17:58:40 elwinter Exp $

# NOTE: All internal subroutine names start with a leading underscore
# (_) character, and assume that their inputs are valid.

#******************************************************************************

=pod

=head1 NAME

Astro::VO::VOTable::TABLE - VOTable TABLE element class

=head1 SYNOPSIS

use Astro::VO::VOTable::TABLE;

=head1 DESCRIPTION

This class implements an interface to VOTable TABLE elements. This
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
in the TABLE. Return undef if an error occurs.

=head3 get_cell($i, $j)

Return column $j of row $i of the data, as a string. Return undef if
an error occurs. Note that row and field indices start at 0.

=head3 get_field_position_by_name($field_name)

Compute the position of the FIELD element with the specified name, and
return it. Return undef if an error occurs.

=head3 get_field_position_by_ucd($field_ucd)

Compute the position of the FIELD element with the specified UCD, and
return it. Return undef if an error occurs.

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

$Id: TABLE.pm,v 1.1.1.28 2004/02/11 17:58:40 elwinter Exp $

=cut

#******************************************************************************

# Revision history

# $Log: TABLE.pm,v $
# Revision 1.1.1.28  2004/02/11 17:58:40  elwinter
# Fixed another bug introduced when fixing the previous bug.
#
# Revision 1.1.1.27  2004/02/11 17:48:11  elwinter
# Fixed bug in get_field_position_by_ucd() when no UCD is provided.
#
# Revision 1.1.1.26  2003/11/14 15:38:11  elwinter
# Switched to Astro::VO::VOTable:: namespace.
#
# Revision 1.1.1.25  2003/10/31 14:46:20  elwinter
# Overhauled in preparation for redesign.
#
# Revision 1.1.1.24  2003/08/12 17:24:37  elwinter
# Fixed memory leak in get_field_position_by_ucd().
#
# Revision 1.1.1.23  2003/06/08 15:22:19  elwinter
# Added use Carp.
#
# Revision 1.1.1.22  2003/05/16 19:45:18  elwinter
# Invalidated append_DESCRIPTION() and append_DATA() methods.
#
# Revision 1.1.1.21  2003/05/16 13:59:37  elwinter
# Added overriding get_DATA() method.
#
# Revision 1.1.1.20  2003/05/16 13:56:33  elwinter
# Added overriding get_DESCRIPTION() method.
#
# Revision 1.1.1.19  2003/04/09 16:25:00  elwinter
# Changed VERSION to 1.0.
#
# Revision 1.1.1.18  2003/04/07 17:29:02  elwinter
# Updated documentation.
#
# Revision 1.1.1.17  2003/03/20 16:09:37  elwinter
# Added get_array() method.
#
# Revision 1.1.1.16  2003/03/14 13:32:33  elwinter
# Added get_cell() method.
#
# Revision 1.1.1.15  2003/03/12 12:41:44  elwinter
# Overhauled to use XML::LibXML.
#
# Revision 1.1.1.14  2002/11/19 15:14:01  elwinter
# Added code to check for empty table.
#
# Revision 1.1.1.13  2002/11/19 13:53:28  elwinter
# Moved all element accessors to VOTable::Element class.
#
# Revision 1.1.1.12  2002/11/17 16:29:51  elwinter
# Added code for get_valid_child_element_names.
#
# Revision 1.1.1.11  2002/11/17 16:05:32  elwinter
# Added code for get_valid_attribute_names.
#
# Revision 1.1.1.10  2002/11/14 17:12:02  elwinter
# Moved new to Element.
#
# Revision 1.1.1.9  2002/11/14 16:37:19  elwinter
# Moved toString and new_from_xmldom to Element.
#
# Revision 1.1.1.8  2002/11/13 19:04:01  elwinter
# Moved all accessor (get/set/remove methods to VOTable::Element AUTOLOAD.
#
# Revision 1.1.1.7  2002/11/12 15:30:11  elwinter
# Added toString method.
#
# Revision 1.1.1.6  2002/10/25 18:30:48  elwinter
# Changed required Perl version to 5.6.0.
#
# Revision 1.1.1.5  2002/10/25 18:30:22  elwinter
# Changed required Perl version to 5.6.0.
#
# Revision 1.1.1.4  2002/09/11  17:54:13  elwinter
# Added get_num_rows() method.
#
# Revision 1.1.1.3  2002/09/11  17:28:46  elwinter
# Added get_field_position_by_name() and get_field_position_by_ucd() methods.
#
# Revision 1.1.1.2  2002/09/11  17:04:39  elwinter
# Added get_row() method.
#
# Revision 1.1.1.1  2002/09/11  16:23:30  elwinter
# Placeholder for new branch.
#
# Revision 1.1  2002/09/11  15:54:44  elwinter
# Initial revision
#

#******************************************************************************

# Begin the package definition.
package Astro::VO::VOTable::TABLE;

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
use Astro::VO::VOTable::DATA;
use Astro::VO::VOTable::DESCRIPTION;
use Astro::VO::VOTable::FIELD;
use Astro::VO::VOTable::LINK;

#******************************************************************************

# Class constants

#******************************************************************************

# Class variables

our(@valid_attribute_names) = qw(ID name ref);
our(@valid_child_element_names) = qw(DESCRIPTION LINK FIELD DATA);

#******************************************************************************

# Method definitions

#******************************************************************************

sub get_array()
{

    # Save arguments.
    my($self) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Reference to array of table data.
    my($array);

    #--------------------------------------------------------------------------

    # Extract the table data as an array.
    $array = $self->get_DATA(0)->get_array;

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

    # Reference to underlying Astro::VO::VOTable::DATA object.
    my($data);

    # Row of results.
    my(@row);

    #--------------------------------------------------------------------------

    # Extract the row.
    @row = $self->get_DATA(0)->get_row($rownum);

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

    # Extract the cell.
    $cell = $self->get_DATA(0)->get_cell($i, $j);

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

    # Count the rows.
    if ($self->get_DATA(0)) {
	$num_rows = $self->get_DATA(0)->get_num_rows;
    } else {
	$num_rows = 0;
    }

    # Return row count.
    return($num_rows);

}

#******************************************************************************

sub get_field_position_by_name()
{

    # Save arguments.
    my($self, $field_name) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Current FIELD element object.
    my($field);

    # Position of desired FIELD element.
    my($field_position);

    #--------------------------------------------------------------------------

    # Determine the position of the FIELD element with the specified
    # name.
    $field_position = 0;
    foreach $field ($self->get_FIELD) {
	last if $field->get_name eq $field_name;
	$field_position++;
    }

    # Make sure the desired FIELD was found.
    undef($field_position) if $field_position == scalar($self->get_FIELD);

    # Return the FIELD pposition.
    return($field_position);

}

#******************************************************************************

sub get_field_position_by_ucd()
{

    # Save arguments.
    my($self, $field_ucd) = @_;

    #--------------------------------------------------------------------------

    # Local variables.

    # Current FIELD element object.
    my($field);

    # Position of desired FIELD element.
    my($field_position);

    # UCD of current FIELD.
    my($ucd);

    # Temporary array to hold FIELDs.
    my(@fields);

    #--------------------------------------------------------------------------

    # Determine the position of the FIELD element with the specified
    # UCD.
    $field_position = 0;
    foreach $field ($self->get_FIELD) {
	$ucd = $field->get_ucd();
	if (not defined($ucd)) {
	    $field_position++;
	    next;
	}
	last if $ucd eq $field_ucd;
	$field_position++;
    }

    # Make sure the desired FIELD was found.
    @fields = $self->get_FIELD;
    undef($field_position) if $field_position == scalar(@fields);

    # Return the FIELD pposition.
    return($field_position);

}

#******************************************************************************
1;
__END__
