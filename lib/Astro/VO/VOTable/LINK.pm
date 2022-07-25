package Astro::VO::VOTable::LINK;

# ABSTRACT: VOTable LINK element class

use strict;
use warnings;

our $VERSION = '1.1';

use parent 'Astro::VO::VOTable::Element';

our @valid_attribute_names  = qw(ID action content-role content-type gref
                                 href title value);
our @valid_child_element_names  = ();

1;

# COPYRIGHT

__END__

=pod

=head1 SYNOPSIS

use Astro::VO::VOTable::LINK;

=head1 DESCRIPTION

This class implements an interface to VOTable LINK elements. This
class inherits from Astro::VO::VOTable::Element, and therefore all of
the methods from that class are available to this class. This file
will only document the methods specific to this class.

=head1 SEE ALSO

Astro::VO::VOTable::Element

=cut

