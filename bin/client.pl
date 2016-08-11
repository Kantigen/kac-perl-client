#!/usr/bin/perl

use lib '/home/keno/kac-client/lib';
use Log::Log4perl;
use Redis;

use KAC::Config;
use KAC::DB;
use KAC::SDB;
use KAC::Cache;
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

my $redis = Redis->new( server => 'kac-redis:6379');
KAC::Redis->initialize({
    redis => $redis,
});

KAC::Cache->initialize({});

my $count = 0;
while ($count < 1000) {
    KAC::Cache->set('proposition_recently_completed', $count, "value-$count");
    $count++;
}


my $val = KAC::Cache->get('proposition_recently_completed', 666);
print "VALUE [$val]\n";

Log::Log4perl->init('/home/keno/kac-client/etc/log4perl.conf');

my $app = KAC::App::Client->new_with_command();

$app->run;

