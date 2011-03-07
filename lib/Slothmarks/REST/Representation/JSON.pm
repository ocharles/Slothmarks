package Slothmarks::REST::Representation::JSON;
use Moose;

with 'Sloth::Representation';

use JSON::Any;

sub content_type { 'application/json' }

my %map = (
    'Slothmarks::Schema::Result::UserBookmark' => 'serialize_bookmark',
    'Slothmarks::Schema::Result::User' => 'serialize_user'
);

sub serialize {
    my ($self, $object) = @_;
    if(my $method = $map{ref($object)}) {
        $self->$method($object);
    }
}

sub serialize_user {
    my ($self, $user) = @_;
    return JSON::Any->objToJson({
        user_id => $user->user_id,
        full_name => $user->full_name
    });
}

sub serialize_bookmark {
    my ($self, $bm) = @_;
    return JSON::Any->objToJson({
        bookmarker => $bm->user->user_id,
        uri => $bm->bookmark->uri,
        summary => $bm->short_desc,
        description => $bm->long_desc
    });
}

1;
