#!/usr/bin/perl
use warnings;
use strict;
use CGI;
use DBI;
my $q = new CGI;
#Conección DB, de devule el manejador de la base de datos
sub conectionDB () {
  my $user = "alumno";
  my $password = "pweb1";
  my $dsn = "DBI:MariaDB:database=pweb1;host=localhost";

  #dbh se encarga de hacer consultas
  my $dbh = DBI->connect($dsn, $user, $password) or die ("\e[1;31m No se pudo conectar!\n[0m]");
  return $dbh;
}
#Obtienes el manejador y haces una consulta
my $dbh = conectionDB();
my $sth = $dbh->prepare("SELECT * FROM alumno");
$sth->execute();
print $q->header(-type => 'text/html', -charset => 'UTF-8');
while (my @row = $sth -> fetchrow_array) {
  print "@row\n";
}
$sth->finish;
$dbh->disconnect;

#print<<OJOSAZULES;
#Estoy loguwadoooodkoajvbehvbhfbv
#OJOSAZULES
