package Slothmarks::REST::Resource::User::Bookmarks;
use Moose;

with 'Sloth::Resource';

has '+path' => (
    default => 'user/:name/bookmarks/'
);

1;
