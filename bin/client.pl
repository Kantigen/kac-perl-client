#!/usr/bin/perl

use lib '/home/keno/ka-perl-client/lib';
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
my $db = KA::DB->connect(
    'DBI:SQLite:/home/keno/kac-server/log/test.db',
);

KAC::SDB->initialize({
    db => $db,
});

Log::Log4perl->init('/home/keno/kac-server/etc/log4perl.conf');

my $app = KAC::App::Client->new_with_command();

$app->run;

