# NAME

Astro::VO::VOTable - VOTable document manipulation package

# VERSION

version 1.1

# SYNOPSIS

    # load all of the modules in the Astro::VO::VOTable namespace
    use Astro::VO::VOTable;

# DESCRIPTION

The VOTABLE package is a set of Perl modules which provide an
object-oriented interface to VOTABLE-formatted XML files. The software
is built atop the Perl [XML::LibXML](https://metacpan.org/pod/XML%3A%3ALibXML) module, which is a Perl interface
to the C-based libxml2 XML parser.

The VOTABLE software provides a class for each valid element defined
in the VOTABLE DTD.

The programs in the 'examples' subdirectory illustrate the use of the
modules to read a VOTABLE document and access its parts, and the
construction of a VOTABLE document from scratch, and printing it out.

## Outline

Each VOTABLE element has a class for it. All of the element classes
inherit from the [Astro::VO::VOTable::Element](https://metacpan.org/pod/Astro%3A%3AVO%3A%3AVOTable%3A%3AElement) class, which itself inherits from
the [XML::LibXML::Element](https://metacpan.org/pod/XML%3A%3ALibXML%3A%3AElement) class. Therefore, if you need functionality
that is not provided by the VOTable methods, you can probably get the
needed functionality by calling the [XML::LibXML::Element](https://metacpan.org/pod/XML%3A%3ALibXML%3A%3AElement) methods. In a similar vein,
the [AO::VOTable::Document](https://metacpan.org/pod/AO%3A%3AVOTable%3A%3ADocument) class inherits from [XML::LibXML::Document](https://metacpan.org/pod/XML%3A%3ALibXML%3A%3ADocument)q.

Each element class provides get, set, remove, and append accessors for
each child element, and get, set, and remove accessors for each
attribute. The code throws an exception if you use an invalid child
element or invalid attribute.

The set and append methods for child elements all take list
arguments. For elements with individual child elements, the list
should contain a single element; the code does NOT enforce this
restriction at this point, so be careful.

The get methods for child elements all return lists, even when only
one element is expected. Therefore, the get accessor results should be
indexed to get the desired element.

All get, set, append, and remove methods are implemented by the
AUTOLOAD method in [Astro::VO::Table::Element](https://metacpan.org/pod/Astro%3A%3AVO%3A%3ATable%3A%3AElement), greatly decreasing the amount of code
needed to support new elements.

# INTERNALS

# SEE ALSO

XML::LibXML

# SUPPORT

## Bugs

Please report any bugs or feature requests to bug-astro-vo-votable@rt.cpan.org  or through the web interface at: https://rt.cpan.org/Public/Dist/Display.html?Name=Astro-VO-VOTable

## Source

Source is available at

    https://github.com/djerius/p5-Astro-VO-VOTable

and may be cloned from

    https://github.com/djerius/p5-Astro-VO-VOTable.git

# AUTHORS

- Diab Jerius <djerius@cpan.org>
- Eric L Winter

# COPYRIGHT AND LICENSE

This software is copyright (c) 2022 by Smithsonian Astrophysical Observatory; 2002 Laboratory for High-Energy Astrophysics, NASA GSFC.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
