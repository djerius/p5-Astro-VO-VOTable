package Astro::VO::VOTable::TR;

# ABSTRACT: VOTable TR element class

use strict;
use warnings;

our $VERSION = '1.1';

use parent 'Astro::VO::VOTable::Element';

use Astro::VO::VOTable::TD;

our @valid_attribute_names = ();
our @valid_child_element_names = qw(TD);

#------------------------------------------------------------------------------

=method as_array()

Return the contents of the TD elements for this TR element as an array
of values.

=cut

sub as_array()
{
    my($self) = @_;

    my @values;
    push @values, $_->get for $self->get_TD;

    return @values;
}

1;

# COPYRIGHT

__END__

=pod

=head1 SYNOPSIS

use Astro::VO::VOTable::TR;

=head1 DESCRIPTION

This class implements an interface to VOTable TR elements. This class
inherits from Astro::VO::VOTable::Element, and therefore all of the
methods from that class are available to this class. This file will
only document the methods specific to this class.

=head1 SEE ALSO

Astro::VO::VOTable::Element

=cut
