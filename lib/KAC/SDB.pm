package KAC::SDB;

use MooseX::Singleton;
use namespace::autoclean;

has db => (
    is          => 'rw',
    required    => 1,
    isa         => 'KAC::DB',
);

__PACKAGE__->meta->make_immutable;

