package Astro::VO::VOTable::STREAM;

# ABSTRACT: VOTable STREAM element class

use strict;
use warnings;

our $VERSION = '1.1';

use parent 'Astro::VO::VOTable::Element';

our @valid_attribute_names = qw(type href actuate encoding expires rights);
our @valid_child_element_names = ();

1;

# COPYRIGHT

__END__

=pod

=head1 SYNOPSIS

use Astro::VO::VOTable::STREAM;

=head1 DESCRIPTION

This class implements an interface to VOTable STREAM elements. This
class inherits from Astro::VO::VOTable::Element, and therefore all of
the methods from that class are available to this class.

=head1 SEE ALSO

Astro::VO::VOTable::Element

=cut

