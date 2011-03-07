package Slothmarks::Schema::Result::Bookmark;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table('bookmark');
__PACKAGE__->add_columns(qw( hash uri ));
__PACKAGE__->set_primary_key('hash');

1;
