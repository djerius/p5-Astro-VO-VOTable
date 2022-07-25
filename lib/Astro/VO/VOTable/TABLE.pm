package Astro::VO::VOTable::TABLE;

# ABSTRACT: VOTable TABLE element class

use strict;
use warnings;

our $VERSION = '1.1';

use parent 'Astro::VO::VOTable::Element';

use Astro::VO::VOTable::DATA;
use Astro::VO::VOTable::DESCRIPTION;
use Astro::VO::VOTable::FIELD;
use Astro::VO::VOTable::LINK;

our @valid_attribute_names = qw(ID name ref);
our @valid_child_element_names = qw(DESCRIPTION LINK FIELD DATA);

#******************************************************************************

=method get_array()

Return a reference to a 2-D array containing the data contents of the
table. Return undef if an error occurs.

=cut

sub get_array()
{
    my($self) = @_;
    return $self->get_DATA(0)->get_array;
}

#******************************************************************************

=method get_row($rownum)

Return row $rownum of the data, as an array of values. The array
elements should be interpreted in the same order as the FIELD elements
in the TABLE. Return undef if an error occurs.

=cut

sub get_row()
{
    my($self, $rownum) = @_;
    return $self->get_DATA(0)->get_row($rownum);
}

#******************************************************************************

=method get_cell($i, $j)

Return column $j of row $i of the data, as a string. Return undef if
an error occurs. Note that row and field indices start at 0.

=cut

sub get_cell()
{
    my($self, $i, $j) = @_;

    return $self->get_DATA(0)->get_cell($i, $j);
}

#******************************************************************************

=method get_num_rows()

Return the number of rows in the table. Return undef if an error
occurs.

=cut

sub get_num_rows()
{
    my($self) = @_;
    return $self->get_DATA(0) ? $self->get_DATA(0)->get_num_rows : 0;
}

#******************************************************************************

=method get_field_position_by_name($field_name)

Compute the position of the FIELD element with the specified name, and
return it. Return undef if an error occurs.

=cut

sub get_field_position_by_name()
{
    my($self, $field_name) = @_;

    # Determine the position of the FIELD element with the specified
    # name.
    my $field_position = 0;
    foreach my $field ($self->get_FIELD) {
        return $field_position
          if $field->get_name eq $field_name;
        ++$field_position;
    }

    return undef;
}

#******************************************************************************

=method get_field_position_by_ucd($field_ucd)

Compute the position of the FIELD element with the specified UCD, and
return it. Return undef if an error occurs.

=cut

sub get_field_position_by_ucd()
{
    my($self, $field_ucd) = @_;

    my $field_position = 0;
    foreach my $field ($self->get_FIELD) {
        my $ucd = $field->get_ucd();
        return $field_position
          if defined $ucd && $ucd eq $field_ucd;
        ++$field_position;
    }

    return undef;
}

1;

# COPYRIGHT

__END__

=pod

=head1 SYNOPSIS

use Astro::VO::VOTable::TABLE;

=head1 DESCRIPTION

This class implements an interface to VOTable TABLE elements. This
class inherits from Astro::VO::VOTable::Element, and therefore all of
the methods from that class are available to this class. This file
will only document the methods specific to this class.

=head1 SEE ALSO

Astro::VO::VOTable::Element

=cut
