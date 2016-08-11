#!/usr/bin/perl

use lib '/home/keno/kac-client/lib';
use Log::Log4perl;

use KAC::Config;
use KAC::DB;
use KAC::SDB;

use KAC::App::Client;

# Initialize the singletons
#

KAC::Config->initialize;

# Connect to the mysql Docker image
#
my $db = KAC::DB->connect(
    'DBI:SQLite:/home/keno/kac-client/log/test.db',
);

KAC::SDB->initialize({
    db => $db,
});

Log::Log4perl->init('/home/keno/kac-client/etc/log4perl.conf');

my $app = KAC::App::Client->new_with_command();

$app->run;

