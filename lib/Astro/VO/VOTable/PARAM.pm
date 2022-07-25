package Astro::VO::VOTable::PARAM;

# ABSTRACT: VOTable PARAM element class

use strict;
use warnings;

our $VERSION = '1.1';

use parent 'Astro::VO::VOTable::Element';

use Astro::VO::VOTable::DESCRIPTION;
use Astro::VO::VOTable::LINK;
use Astro::VO::VOTable::VALUES;

our @valid_attribute_names = qw(ID unit datatype precision width ref name
                                 ucd value arraysize);
our @valid_child_element_names = qw(DESCRIPTION VALUES LINK);

1;

# COPYRIGHT

__END__

=pod

=head1 SYNOPSIS

use Astro::VO::VOTable::PARAM;

=head1 DESCRIPTION

This class implements an interface to VOTable PARAM elements. This
class inherits from Astro::VO::VOTable::Element, and therefore all of
the methods from that class are available to this class. This file
will only document the methods specific to this class.

=head1 SEE ALSO

Astro::VO::VOTable::Element

=cut
