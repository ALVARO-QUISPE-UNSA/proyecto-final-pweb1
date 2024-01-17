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
#Ejemplo
#      my $dbh = conectionDB();
#      my $sth = $dbh->prepare("SELECT * FROM alumno");
#      $sth->execute();
#      print $q->header(-type => 'text/html', -charset => 'UTF-8');
#      while (my @row = $sth -> fetchrow_array) {
#        print "@row\n";
#      }
#      $sth->finish;
#      $dbh->disconnect;
#-------------------------------
#Motrarar información según datos del alumnado
my $dni = $q->param("dni");
my $dbh = conectionDB();
my $sth = $dbh->prepare("SELECT * FROM alumno WHERE dni = ?");
$sth->execute($dni);
#hasta el momento ejecuté la consulta
#creo este diccionario que contenga los datos de la fila
my %row;
#esto hace una referencia hacia los datos
$sth -> bind_columns( \(@row{ @{$sth->{NAME}} } ));
#Esto jala/busca los datos de la consulta
$sth->fetch;
#encabezado
print $q->header(-type => 'text/html', -charset => 'UTF-8');
#El for va a recorrer los cambos, en esta caso, dni, nombre...
foreach my $key (@{$sth->{NAME}}) {
  print "<td>$row{$key}</td>\n";
}
my $nombre = $row{"nombre"};
print "$nombre\n";
#print "El dni es: $row{"dni"} y su nombre $row{"nombre"}\n";
$sth->finish;
$dbh->disconnect;
#print<<OJOSAZULES;
#Estoy loguwadoooodkoajvbehvbhfbv
#OJOSAZULES
