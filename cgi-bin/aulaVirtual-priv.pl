#!/usr/bin/perl
use lib "/home/alumno/perl5/lib/perl5";
use warnings;
use strict;
use CGI;
use CGI::Session;
use DBI;

my $q = CGI->new;
my $sessionId = $q->cookie('sessionId');
my $session = CGI::Session->load($sessionId);

#Gestionar tiempo de aula virtual
if ($session->is_expired) {
  print $q->header(-type => 'text/html', -charset => 'UTF-8');
  print "<html><body>";
  print "<p>Su sesión ha expirado. Por favor inicie sesión nuevamente</a>.</p>";
  print "<form action='../login.html' method='GET'>";
  print "<input type='submit' value='Iniciar sesión'>";
  print "</form>";
  print "</body></html>";
  exit;
}

# Recuperamos los datos
my $nombreAlumno = $session->param("nombreAlumno");
my $apellido1 = $session->param("apellidoUno");
my $apellido2 = $session->param("apellidoDos");
my $dni = $session->param("dni");

##################
##################
#funciones herramienta
##################
##################
#Función para la conexión a la base de datos
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

#Nos conectamos a la base de datos
my $dbh = connectDB();

#Recuperamos los datos personales
my %datosPersonales = datosAlumno($dni);

my $email = $datosPersonales{"email"};
print $q->header(-type => 'text/html', -charset => 'UTF-8');

print<<AULAVIRTUAL;

AULAVIRTUAL

