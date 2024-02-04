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
sub listaIDturnos {
  my $dni = $_[0];

  my $sth = $dbh->prepare("SELECT * FROM alumno WHERE dni = ?");
  $sth->execute($dni);
}

#Recuperamos los datos personales
my %datosPersonales = datosAlumno($dni);

my $email = $datosPersonales{"email"};
print $q->header(-type => 'text/html', -charset => 'UTF-8');

print<<AULAVIRTUAL;
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title></title>
</head>
<body>
  <h1>Sectores en la barra lateral</h1> 
  <ul>
    <li>Logo piensa </li>
    <li>botón home (lo que se muestra al acceder)</li>
    <li>cursos </li>
    <li>profesores</li>
    <li>en la parte de abajo, botón información personal</li>
  </ul>
  <h2>A Parte de cursos</h2>
  <b>Contenido de Tarjetas</b>
  <!--
    podría hacer unna lista de diccionarios que contenga la 
    información de tabla turno según resultados turnos_alumno
  -->
  <ol>
    <li>Imagen (identificable con el título del curso)</li>
    <li>turno</li>
    <li>hora inicio</li>
    <li>hora final</li>
    <li>profesor que dicta</li>
    <li>hora de inicio</li>
    <li>hora de fianl</li>
    <li>aula que le toca</li>
  </ol>

  <h2>B Parte de profesores</h2>
  <b>Contenido de tarjetas</b>
  <ol>
    <li>imagen de profesor (según dni en base de datos)</li>
    <li>nombre profesor</li>
    <li>apellidos 1 y 2</li>
    <li>curso que dicta</li>
    <li>email</li>
    <li>experiencia</li>
  </ol>

  <h2>C Información personal</h2>
  <b>Panel de información general</b>
  <p>Este será como un panel que incluya la siguiente 
    información referente al alumno</p>
  <ol>
    <li>nombre: $datosPersonales{"nombre"}</li>

    <li>apellidos: 1: $datosPersonales{"apellido1"}</li>
    <li>apellidos: 2: $datosPersonales{"apellido2"}</li>
    <li>telefono: $datosPersonales{"telefono"}</li>
    <li>email: $datosPersonales{"email"}</li>
  </ol>
  <b>Tarjetas de matriculas actuales</b>
  <p>Será un conglomerado de tarjetas con
  estructura similar a las anteriores con datos relativos
  a las matrículas</p>
  <ol>
    <li>nombre curso</li>
    <li>fecha de inicio</li>
    <li>fecha de finalización</li>
    <li>costo:</li>
    <li>botón: ir al curso, te redirije</li>
  </ol>


</body>
</html>
AULAVIRTUAL


