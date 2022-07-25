package Astro::VO::VOTable::TABLEDATA;

# ABSTRACT: VOTable TABLEDATA element class

use strict;
use warnings;

our $VERSION = '1.1';

use parent 'Astro::VO::VOTable::Element';

use Astro::VO::VOTable::TR;

our @valid_attribute_names = ();
our @valid_child_element_names = qw(TR);

=method get_array()

Return a reference to a 2-D array containing the data contents of the
table. Return undef if an error occurs.

=cut

sub get_array()
{
    my($self) = @_;

    # Create the array to hold the data.
    my @array;

    # Fetch a list of the TR elements.
    my $nodelist = $self->getChildrenByTagName('TR')
      or return undef;

    # Fetch the number of rows in the table.
    my $num_rows = $nodelist->size;

    # Process each TR element.
    for my $i ( 1.. $num_rows ) {
        my $tr = $nodelist->get_node($i) or return undef;
        $tr = Astro::VO::VOTable::TR->new($tr) or return undef;
        push @array, [$tr->as_array];
    }

    return \@array;
}

#------------------------------------------------------------------------------

=method get_row($rownum)

Return row $rownum of the data, as an array of values. The array
elements should be interpreted in the same order as the FIELD elements
in the enclosing TABLE element. Return undef if an error occurs.

=cut

sub get_row()
{
    my($self, $rownum) = @_;

    # Fetch a list of the TR elements.
    my $nodelist = $self->getChildrenByTagName('TR') or return undef;

    # Fetch the specific TR element.
    my $tr = $nodelist->get_node($rownum + 1) or return undef;
    $tr = Astro::VO::VOTable::TR->new($tr) or return undef;

    return $tr->as_array;
}

#------------------------------------------------------------------------------

=method get_cell($i, $j)

Return column $j of row $i of the data, as a string. Return undef if
an error occurs. Note that row and field indices start at 0.

=cut

sub get_cell()
{
    my($self, $i, $j) = @_;

    # Fetch a list of the TR elements.
    my $tr_nodelist = $self->getChildrenByTagName('TR') or return undef;

    # Fetch the specific TR element.
    my $tr = $tr_nodelist->get_node($i + 1) or return undef;

    # Fetch a list of the TD elements.
    my $td_nodelist = $tr->getChildrenByTagName('TD') or return undef;

    # Fetch the specific TD element.
    my $td = $td_nodelist->get_node($j + 1) or return undef;
    $td = Astro::VO::VOTable::TD->new($td) or return undef;

    # Return the cell value.
    return $td->get;
}

#------------------------------------------------------------------------------

=method get_num_rows()

Return the number of rows in the table. Return undef if an error
occurs.

=cut

sub get_num_rows()
{
    my($self) = @_;

    my $nodelist = $self->getChildrenByTagName('TR') or return undef;
    return $nodelist->size;
}


1;

# COPYRIGHT

__END__

=pod

=head1 SYNOPSIS

use Astro::VO::VOTable::TABLEDATA;

=head1 DESCRIPTION

This class implements an interface to VOTable TABLEDATA elements. This
class inherits from Astro::VO::VOTable::Element, and therefore all of
the methods from that class are available to this class. This file
will only document the methods specific to this class.

=head1 SEE ALSO

Astro::VO::VOTable::Element

=cut
