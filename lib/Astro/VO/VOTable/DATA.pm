package Astro::VO::VOTable::DATA;

# ABSTRACT: VOTable DATA element class

use strict;
use warnings;

our $VERSION = '1.1';

use parent 'Astro::VO::VOTable::Element';

use Astro::VO::VOTable::BINARY;
use Astro::VO::VOTable::FITS;
use Astro::VO::VOTable::TABLEDATA;

our @valid_attribute_names  = ();
our @valid_child_element_names = qw(TABLEDATA BINARY BINARY2 FITS INFO);

#******************************************************************************

=method  get_array()

Return a reference to a 2-D array containing the data contents of the
table. Return undef if an error occurs.

=cut

sub get_array()
{
    my($self) = @_;

    return $self->get_TABLEDATA(0) ? $self->get_TABLEDATA(0)->get_array : undef;
}

#******************************************************************************

=method get_row($rownum)

Return row $rownum of the data, as an array of values. The array
elements should be interpreted in the same order as the FIELD elements
in the enclosing TABLE element. Return undef if an error occurs.

=cut

sub get_row()
{
    my($self, $rownum) = @_;

    return $self->get_TABLEDATA(0) ? $self->get_TABLEDATA(0)->get_row( $rownum ) : undef;
}

#******************************************************************************

=method get_cell($i, $j)

Return column $j of row $i of the data, as a string. Return undef if
an error occurs. Note that row and field indices start at 0. NOTE:
This method is slow, and should only be used in situations where speed
is not a concern.

=cut

sub get_cell()
{
    my($self, $i, $j) = @_;

    return $self->get_TABLEDATA(0) ? $self->get_TABLEDATA(0)->get_cell( $i, $j ) : undef;
}

#******************************************************************************

=method get_num_rows()

Return the number of rows in the table. Return undef if an error
occurs.

=cut

sub get_num_rows()
{
    my($self) = @_;

    return $self->get_TABLEDATA(0) ? $self->get_TABLEDATA(0)->get_num_rows : undef;
}

1;

# COPYRIGHT

__END__

=pod

=head1 SYNOPSIS

use Astro::VO::VOTable::DATA;

=head1 DESCRIPTION

This class implements an interface to VOTable DATA elements. This
class inherits from Astro::VO::VOTable::Element, and therefore all of
the methods from that class are available to this class. This file
will only document the methods specific to this class.

=head1 SEE ALSO

Astro::VO::VOTable::Element

=cut
