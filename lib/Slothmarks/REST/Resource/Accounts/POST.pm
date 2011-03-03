package Slothmarks::REST::Resource::Accounts::POST;
use Moose;
use namespace::autoclean;

with 'Sloth::Method';

use Data::TreeValidator::Constraints qw( required );
use Data::TreeValidator::Sugar qw( leaf branch );
use HTTP::Status qw( HTTP_CREATED );
use HTTP::Throwable::Factory 'http_throw';
use Sloth::RequestParser::Form;
use Try::Tiny;

use aliased 'Sloth::Response';

has '+request_data_validator'  => (
    default => sub {
        branch {
            user_id   => leaf(constraints => [ required ]),
            password  => leaf(constraints => [ required ]),
            full_name => leaf(),
        }
    }
);

has '+request_parsers' => (
    default => sub {
        return {
            'application/x-www-form-urlencoded' => Sloth::RequestParser::Form->new
        }
    }
);

sub execute {
    my ($self, $input, $request) = @_;

    if ($self->c->schema->resultset('User')->find($input->{user_id})) {
        http_throw('Conflict' => {
            message => 'An account with this name already exists'
        });
    }
    else {
        my $user = try {
            $self->c->schema->resultset('User')->create($input);
        }
        catch {
            http_throw('BadRequest' => { message => $_ });
        };

        return Response->new(
            HTTP_CREATED,
            [
                Location => $request->uri_for(
                    resource => 'user',
                    name => $user->user_id
                )
            ]
        );
    }
}

__PACKAGE__->meta->make_immutable;
1;
