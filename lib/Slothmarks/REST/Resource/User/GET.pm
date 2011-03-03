package Slothmarks::REST::Resource::User::GET;
use Moose;
use namespace::autoclean;

use Data::TreeValidator::Constraints qw( required );
use Data::TreeValidator::Sugar qw( branch leaf );
use HTTP::Throwable::Factory qw( http_throw );

with 'Sloth::Method';

has '+request_data_validator'  => (
    default => sub {
        branch {
            name => leaf(constraints => [ required ])
        }
    }
);

sub execute {
    my ($self, $params) = @_;

    my $user = $self->c->schema->resultset('User')
        ->find($params->{name})
            or http_throw('NotFound');
}

__PACKAGE__->meta->make_immutable;
1;
