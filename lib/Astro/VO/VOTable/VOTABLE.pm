package Astro::VO::VOTable::VOTABLE;

# ABSTRACT: VOTable VOTABLE element class

use strict;
use warnings;

our $VERSION = '1.1';

use parent 'Astro::VO::VOTable::Element';

use Astro::VO::VOTable::RESOURCE;
use Astro::VO::VOTable::DEFINITIONS;
use Astro::VO::VOTable::DESCRIPTION;
use Astro::VO::VOTable::INFO;

our @valid_attribute_names = qw(ID version);
our @valid_child_element_names = qw(DESCRIPTION DEFINITIONS INFO RESOURCE);

1;

# COPYRIGHT

__END__

=pod

=head1 SYNOPSIS

use Astro::VO::VOTable::VOTABLE;

=head1 DESCRIPTION

This class implements an interface to VOTable VOTABLE elements. This
class inherits from VOTable::Element, and therefore all of the methods
from that class are available to this class. This file will only
document the methods specific to this class.

=head1 SEE ALSO

Astro::VO::VOTable::Element

=cut
