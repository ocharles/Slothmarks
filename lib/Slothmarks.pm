package Slothmarks;
use Moose;
use namespace::autoclean;

use Slothmarks::Schema;

has schema => (
    is => 'ro',
    default => sub {
        Slothmarks::Schema->connect(
            'dbi:Pg:dbname=slothmarks',
            'slothmarks',
            '',
            { RaiseError => 1 }
        );
    }
);

__PACKAGE__->meta->make_immutable;
1;
