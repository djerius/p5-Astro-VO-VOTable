use ExtUtils::MakeMaker;

# Write the Makefile.
WriteMakefile(
	      'NAME' => 'Astro::VO::VOTable::INFO',
	      'VERSION_FROM' => 'INFO.pm',
	      'PREREQ_PM' => {},
	      'ABSTRACT_FROM' => 'INFO.pm',
	      'AUTHOR' => 'Eric Winter <Eric.L.Winter.1@gsfc.nasa.gov>',
	      );
