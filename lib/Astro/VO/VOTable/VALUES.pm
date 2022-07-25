package Astro::VO::VOTable::VALUES;

# ABSTRACT: VOTable VALUES element class

use strict;
use warnings;

our $VERSION = '1.1';

use parent 'Astro::VO::VOTable::Element';

use Astro::VO::VOTable::MAX;
use Astro::VO::VOTable::MIN;
use Astro::VO::VOTable::OPTION;

our @valid_attribute_names = qw(ID type null invalid);
our @valid_child_element_names = qw(MIN MAX OPTION);

1;

# COPYRIGHT

__END__

=pod

=head1 SYNOPSIS

use Astro::VO::VOTable::VALUES;

=head1 DESCRIPTION

This class implements an interface to VOTable VALUES elements. This
class inherits from Astro::VO::VOTable::Element, and therefore all of
the methods from that class are available to this class. This file
will only document the methods specific to this class.

=head1 SEE ALSO

Astro::VO::VOTable::Element

=cut
