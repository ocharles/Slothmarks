package Slothmarks::REST::Resource::User::Bookmark;
use Moose;

with 'Sloth::Resource';

has '+path' => (
    default => 'user/:name/bookmark/:hash/'
);

1;
