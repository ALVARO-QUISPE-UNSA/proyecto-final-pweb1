#!/usr/bin/perl
use lib "/home/alumno/perl5/lib/perl5";
use warnings;
use strict;
use CGI;
use DBI;

my $q = CGI->new;





##################
##################
#funciones herramienta
##################
##################
#Función para la conexión a la base de datos
my $dbh = connectDB();
sub connectDB {
  my $user = "alumno";
  my $pass = "pweb1";
  my $dsn = "DBI:MariaDB:database=pweb1;host=localhost";
  my $dbh = DBI->connect($dsn, $user, $pass) or die ("\e[1;31m No se pudo conectar!\n[0m]");
  return $dbh;
}

#Función para recuperar datos personles
#Parte C, información personal
sub datosAlumno {
  my $dni = $_[0];

  my $sth = $dbh->prepare("SELECT * FROM alumno WHERE dni = ?");
  $sth->execute($dni);

  my %row;
  $sth -> bind_columns( \(@row{ @{$sth->{NAME}} } ));
  $sth->fetch;
  $sth -> finish;
  return %row;
}

#Parte A, de cursos, 
#Se hace una lista de los id del alumno
sub getListaTurnos {
  my $dni = $_[0];
  my @ids;
  #my $sth = $dbh->prepare("SELECT id_turno FROM turnos_alumno WHERE dni_alumno = ?");
  my $sth = $dbh->prepare("SELECT id_turno FROM turnos_alumno WHERE dni_alumno = 56789012");
  #$sth->execute($dni);
  $sth->execute();
  while (my @row = $sth->fetchrow_array){
    print "@row\n$row[0]\n\n";
    push(@ids, $row[0]);
  }
  return @ids;
}

sub listaIDturnos {
  my $dni = $_[0];

  my $sth = $dbh->prepare("SELECT * FROM alumno WHERE dni = ?");
  $sth->execute($dni);
}
####################################
####################################
####################################
#MAIN
####################################
####################################
#Recuperamos los datos personales
my $dni = $ARGV[0];
my %datosPersonales = datosAlumno($dni); 
#Obtenenmos la lista de cursos
my @idCursos = getListaTurnos($dni);
my $email = $datosPersonales{"email"};
print $q->header(-type => 'text/html', -charset => 'UTF-8');


##Funciones auxiliares
my $nombre = $datosPersonales{"nombre"};
print "<h1>Pruebas:</h1>\n";
print "<h2>$nombre</h2>\n";
print "<ol><li>Cursos:</li>";
foreach my $id (@idCursos) {
  print "<li>$id</li>\n";
}
print "</ol>";

