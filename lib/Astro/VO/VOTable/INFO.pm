package Astro::VO::VOTable::INFO;

# ABSTRACT: VOTable INFO element class

use strict;
use warnings;

our $VERSION = '1.1';

use parent 'Astro::VO::VOTable::Element';

our @valid_attribute_names = qw(ID name value);
our @valid_child_element_names = ();

1;

# COPYRIGHT

__END__

=head1 SYNOPSIS

use Astro::VO::VOTable::INFO;

=head1 DESCRIPTION

This class implements an interface to VOTable INFO elements. This
class inherits from Astro::VO::VOTable::Element, and therefore all of
the methods from that class are available to this class. This file
will only document the methods specific to this class.

=head1 SEE ALSO

Astro::VO::VOTable::Element
