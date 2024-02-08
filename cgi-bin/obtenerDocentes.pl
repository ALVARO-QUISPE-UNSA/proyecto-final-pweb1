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


my @infoProfesores;

#Obtengo los id de los cursos
my $sth = $dbh->prepare("SELECT * FROM profesores");
$sth->execute();
#Obtengo los turnos de los cursos, con su profesor
while (my $infoDoc = $sth->fetchrow_hashref) {
  #Se obtiene cursos que dicta
  my @cursos;
  #print $infoDoc->{dni}."\n";
  my $sth2 = $dbh->prepare("SELECT nombre FROM curso WHERE id_curso IN (SELECT id_curso FROM turnos WHERE dni_profesor = $infoDoc->{dni});
    ");
  $sth2->execute();
  while (my $curso = $sth2->fetchrow_hashref) {
    push (@cursos, $curso->{nombre});
  }
  $sth2->finish();
  $infoDoc->{cursos_dictados} = \@cursos;
  push (@infoProfesores, $infoDoc);
}

sub respuestaJSON {
  my ($info) = @_;

  print $q->header(-type => 'application/json', -charset => 'utf-8');
  # print to_json($info);

  print encode_json($info);
  #foreach my $data (@_) {
  #  print encode_json($data);
  #}
  exit;
}
$sth->finish();  # Liberar recursos del statement handle
$dbh->disconnect();
#print $infoCursos[1]->{nombre}."\n";
respuestaJSON(\@infoProfesores);
#print $infoCursos[0]->{nombre}."\n";
#print $infoCursos[1]->{nombre}."\n";
#print $infoCursos[1]->{turnos}[0]->{hora_inicio}."\n";


