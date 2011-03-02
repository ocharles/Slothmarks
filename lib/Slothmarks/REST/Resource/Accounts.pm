package Slothmarks::REST::Resource::Accounts;
use Moose;
use namespace::autoclean;

with 'Sloth::Resource';

has '+path' => ( default => 'accounts/' );

__PACKAGE__->meta->make_immutable;
1;
