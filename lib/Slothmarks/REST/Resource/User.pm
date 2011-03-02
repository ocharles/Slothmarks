package Slothmarks::REST::Resource::User;
use Moose;
use namespace::autoclean;

with 'Sloth::Resource';

has '+path' => ( default => 'user/:name/' );

__PACKAGE__->meta->make_immutable;
1;
