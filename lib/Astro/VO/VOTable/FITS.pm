package Astro::VO::VOTable::FITS;

# ABSTRACT: VOTable FITS element class

use strict;
use warnings;

our $VERSION = '1.1';

use parent 'Astro::VO::VOTable::Element';
use Astro::VO::VOTable::STREAM;

our @valid_attribute_names = qw(extnum);
our @valid_child_element_names = qw(STREAM);

1;

# COPYRIGHT

__END__

=pod

=head1 SYNOPSIS

use Astro::VO::VOTable::FITS;

=head1 DESCRIPTION

This class implements an interface to VOTable FITS elements. This
class inherits from Astro::VO::VOTable::Element, and therefore all of
the methods from that class are available to this class. This file
will only document the methods specific to this class.

=head1 WARNINGS

=over 4

=item

The code does NOT currently enforce the restriction of a FITS element
having only a single STREAM child element.

=back

=head1 SEE ALSO

Astro::VO::VOTable::Element

=cut
