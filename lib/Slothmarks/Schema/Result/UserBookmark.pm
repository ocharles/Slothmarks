package Slothmarks::Schema::Result::UserBookmark;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table('user_bookmark');
__PACKAGE__->add_columns(qw( hash short_desc long_desc user_id ));
__PACKAGE__->set_primary_key('hash');

__PACKAGE__->belongs_to(
    user => 'Slothmarks::Schema::Result::User',
    'user_id'
);

__PACKAGE__->has_one(
    bookmark => 'Slothmarks::Schema::Result::Bookmark',
    'hash'
);

1;
