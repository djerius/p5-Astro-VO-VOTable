package Astro::VO::VOTable::Role::ExtractData;

use Role::Tiny;

our $VERSION = '1.1';

requires qw( get_array get_row get_cell get_num_rows );

1;
