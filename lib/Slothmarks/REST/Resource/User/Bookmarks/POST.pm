package Slothmarks::REST::Resource::User::Bookmarks::POST;
use Moose;

use Data::TreeValidator::Constraints qw( required );
use Data::TreeValidator::Sugar qw( branch leaf );
use Digest::SHA qw(sha256_hex);
use HTTP::Status qw( HTTP_CREATED );
use HTTP::Throwable::Factory 'http_throw';
use URI;

with 'Sloth::Method';

use aliased 'Sloth::Response';

has '+request_parsers' => (
    default => sub {
        { 'application/x-www-form-urlencoded' => Sloth::RequestParser::Form->new }
    }
);

has '+request_data_validator' => (
    default => sub {
        branch {
            uri => leaf(constraints => [ required ]),
            short_desc => leaf,
            long_desc => leaf,
            name => leaf(constraints => [ required ])
        }
    }
);

sub execute {
    my ($self, $input, $request) = @_;

    my $uri = URI->new($input->{uri})->canonical;
    my $hash = sha256_hex($uri->as_string);
    if ($self->c->schema->resultset('UserBookmark')->find($hash)) {
        http_throw(Conflict => {
            message => 'You have already bookmarked ' . $uri
        });
    }

    my $ub = $self->c->schema->txn_do(sub {
        my $bookmark = $self->c->schema->resultset('Bookmark')->find_or_create({
            uri => $uri->as_string,
            hash => $hash
        });

        my $user_bookmark = $self->c->schema->resultset('UserBookmark')->create({
            bookmark => $bookmark,
            user => $self->c->schema->resultset('User')->find($input->{name}),
            short_desc => $input->{short_desc},
            long_desc => $input->{long_desc}
        });

        return Response->new(
            HTTP_CREATED,
            [
                Location => $request->uri_for(
                    resource => 'bookmark',
                    hash => $hash,
                    name => $input->{name}
                )
            ],
            $self->try_serialize($user_bookmark)
        );
    });
}

1;
