package Slothmarks::REST::Representation::JSON;
use Moose;

with 'Sloth::Representation';

use JSON::Any;

sub content_type { 'application/json' }

my %map = (
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

1;
