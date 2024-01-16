#!/usr/bin/perl
use warnings;
use strict;
use CGI;
use DBI;
my $q = new CGI;
my $user = 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.0.5";
my $dbh = DBI->connect($dsn, $user, $password) or die ("\e[1;31m Hola, este texto es rojo!\n[0m]");


#MAIN-----------------------
print "Content-type: text/html\n\n";
print "<h1>Hola mundo</h1>\n";
