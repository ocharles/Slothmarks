package Slothmarks::REST;
use Moose;
use namespace::autoclean;

use Slothmarks;

extends 'Sloth';

has '+c' => (
    is => 'ro',
    default => sub {
        Slothmarks->new;
    }
);

__PACKAGE__->meta->make_immutable;
1;
