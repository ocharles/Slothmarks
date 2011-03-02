package Slothmarks::Schema::Result::User;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table('account');
__PACKAGE__->add_columns(qw( user_id full_name email password ));
__PACKAGE__->set_primary_key('user_id');

1;
