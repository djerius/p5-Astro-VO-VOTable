package Astro::VO::VOTable::DEFINITIONS;

# ABSTRACT: VOTable DEFINITIONS element class

use strict;
use warnings;

our $VERSION = '1.1';

use parent 'Astro::VO::VOTable::Element';

use Astro::VO::VOTable::COOSYS;
use Astro::VO::VOTable::PARAM;

our @valid_attribute_names = ();
our @valid_child_element_names = qw(COOSYS PARAM);

1;

# COPYRIGHT

__END__

=pod

=head1 SYNOPSIS

use Astro::VO::VOTable::DEFINITIONS;

=head1 DESCRIPTION

This class implements an interface to VOTable DEFINITIONS
elements. This class inherits from Astro::VO::VOTable::Element, and
therefore all of the methods from that class are available to this
class. This file will only document the methods specific to this
class.

=head1 SEE ALSO
Astro::VO::VOTable::Element

=cut
