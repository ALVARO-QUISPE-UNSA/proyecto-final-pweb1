#!/usr/bin/perl
use lib "/home/alumno/perl5/lib/perl5";
use warnings;
use strict;
use CGI;
use DBI;
use JSON;
#binmode(STDOUT, ":utf8");

my $q = CGI->new;
# Lista que contenga diccionarios de información
# cada diccionario contiene.
  # Nombre del curso.
  # id  "para la imagen""
  # los turnos en que se puede disctar
  # los materiales que se recomiendan
  # profesores que lo están dictando
  #
#Me conecto a la base de datos
sub connectDB {
  my $user = "alumno";
  my $pass = "pweb1";
  my $dsn = "DBI:MariaDB:database=pweb1;host=localhost";
  my $dbh = DBI->connect($dsn, $user, $pass) or die ("\e[1;31m No se pudo conectar!\n[0m]");
  return $dbh;
}
my $dbh = connectDB();


my @infoCursos;

#Obtengo los id de los cursos
my $sth = $dbh->prepare("SELECT * FROM curso");
$sth->execute();
#Obtengo los turnos de los cursos, con su profesor
while (my $infoTarjeta = $sth->fetchrow_hashref) {
  my $sth2 = $dbh->prepare("SELECT dni_profesor, hora_inicio, hora_fin FROM turnos WHERE id_curso = $infoTarjeta->{id_curso}");
  $sth2->execute();
  my @turnos;
  #Se va a acumentar los datos del profesor
  while (my $infoTurno = $sth2->fetchrow_hashref) {
    my $profesor = $dbh->selectrow_hashref("SELECT nombre, apellido1, apellido2 FROM profesores WHERE dni = $infoTurno->{dni_profesor}");
    $infoTurno->{profesor} = $profesor;
    push (@turnos, $infoTurno);
  }
  #print $infoTarjeta->{nombre}."\n";
  #Se va a obtener los materiales para el curso
  #print $infoTarjeta->{id_curso}."\n";
  my @materiales;
  $sth2 = $dbh->prepare("SELECT nombre FROM materiales WHERE id_material IN (SELECT id_material FROM materiales_por_temas WHERE id_tema IN (SELECT id_tema FROM temas_por_curso WHERE id_curso = $infoTarjeta->{id_curso}))");
  $sth2->execute();
  while (my $curso = $sth2->fetchrow_hashref) {
    push (@materiales, $curso->{nombre});
  }
  #Se añaden los turnos y los materiales al diccionario general
  $infoTarjeta->{turnos} = \@turnos;
  $infoTarjeta->{materiales} = \@materiales;
  #Se añade el diccionario a la lista de cursos
  push (@infoCursos, $infoTarjeta);

  #print $dicIDcursos->{nombre}."\n";
  #

}

sub respuestaJSON {
  my ($info) = @_;

  print $q->header(-type => 'application/json', -charset => 'utf-8');
  # print to_json($info);
  print encode_json($info);
  exit;
}
$sth->finish();  # Liberar recursos del statement handle
$dbh->disconnect();
respuestaJSON(@infoCursos);
#print $infoCursos[0]->{nombre}."\n";
#print $infoCursos[1]->{nombre}."\n";
#print $infoCursos[1]->{turnos}[0]->{hora_inicio}."\n";


