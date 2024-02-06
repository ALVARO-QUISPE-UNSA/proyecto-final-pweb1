#!/usr/bin/perl
use lib "/home/alumno/perl5/lib/perl5";
use warnings;
use strict;
use CGI;
use CGI::Session;
use DBI;
use JSON;

my $q = CGI->new;
my $sessionId = $q->cookie('sessionId');
my $session = CGI::Session->load($sessionId);
my $dbh = connectDB();

my $query = $q->param("query");
# Recuperar la sesion
my $dni = $session->param("dni");

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



=pod
Logica de las peticiones:
- La solicitudes fetch ingresaran con un identificador. Ese identificador la capturamos en la varible 
  $query, esta variable es como una constante que nos ayuda a verificar que solicita el usuario.
- Con esta varible realizamos la comparacion:
  
  if ($accion eq "cursos") {
    my $cursos = misCursos($dni);
    respuestaJSON($cursos);
  }
  elsif ($accion eq "profesores") {
    my $profesores = misProfesores($dni);
    respuestaJSON($profesores);
  }
  ...

- Asi concluye la logica equisde, por el momento esta horrible la subrutina misCursos, puedes mejorarlo Alvaro,
  pero para que te guies lo hice que funcione como sea.
=cut


################### FUNCIONES PARA OBETENR INFORMACION DE CURSOS #####################
sub misCursos {
  my $dni = $_[0];
  my @turnos = misTurnos($dni);
  my @cursos;

  # Datos a recuperar
  my $curso;
  my $aula;
  my $profesor;
  my $hora_inicio;
  my $hora_fin;
  my $fecha_inicio;
  my $fecha_fin;
  my $duracion;

  # Para otras consultas
  my $id_curso;
  my $dni_profesor;

  # Iteramos por todos los turnos (cursos)
  foreach my $turno (@turnos) {
    # Consulta a turnos
    my $sth = $dbh->prepare("SELECT id_curso, id_aula, dni_profesor, hora_inicio, hora_fin, duracion FROM turnos WHERE id_turno = ?");
    $sth->execute($turno);
    while (my @row = $sth->fetchrow_array) {
      $id_curso = $row[0];
      $aula = $row[1];
      $dni_profesor = $row[2];
      $hora_inicio = $row[3];
      $hora_fin = $row[4];
      $duracion = $row[5];
    }

    # Consulta a curso
    $sth = $dbh->prepare("SELECT nombre FROM curso WHERE id_curso = ?");
    $sth->execute($id_curso);
    my $row = $sth->fetchrow_hashref;
    $curso = $row->{nombre};

    # Consulta a profesor
    $sth = $dbh->prepare("SELECT nombre, apellido1, apellido2 FROM profesores WHERE dni = ?");
    $sth->execute($dni_profesor);
    $row = $sth->fetchrow_hashref;
    $profesor = $row->{nombre} . ' ' . $row->{apellido1} . ' ' . $row->{apellido2};

    # Consulta a matricula
    $sth = $dbh->prepare("SELECT fecha_emision, fecha_vencimiento FROM matricula WHERE id_alumno = ? AND id_curso = ?");
    $sth->execute($dni, $id_curso);
    $row = $sth->fetchrow_hashref;
    $fecha_inicio = $row->{fecha_emision};
    $fecha_fin = $row->{fecha_vencimiento};

    # Agregamos los datos al arreglo de hash
    my %curso = (
      curso => $curso,
      aula => $aula,
      profesor => $profesor,
      hora_inicio => $hora_inicio,
      hora_fin => $hora_fin,
      fecha_inicio => $fecha_inicio,
      fecha_fin => $fecha_fin,
      duracion => $duracion,
    );
    push @cursos, \%curso;
  }

  return \@cursos;
}

sub misTurnos {
  my $dni = $_[0];
  my @turnos;

  # Preparamos y ejecutamos la solicitud
  my $sth = $dbh->prepare("SELECT id_turno FROM turnos_alumno WHERE dni_alumno = ?");
  $sth->execute($dni);

  # En general, se debe enviar un arreglo de hashes, en cada posicion es un curso con sus propiedades
  while(my @row = $sth->fetchrow_array) {
    push(@turnos, $row[0]);
  }

  return @turnos;
}

################### FUNCIONES PARA OBETENR INFORMACION DE PROFESORES #####################
sub misProfesores {
  my @profesores;
  
  foreach my $id (@_) { #Funciona con la lista de turnos
    my $dic = $dbh->selectrow_hashref("SELECT * FROM profesores WHERE dni = (SELECT dni_profesor FROM turnos WHERE id_turno = $id)");
    my $dicCurso = $dbh->selectrow_hashref("SELECT nombre FROM curso WHERE id_curso = (SELECT id_curso FROM turnos WHERE id_turno = $id)");
    $dic->{"curso"} = $dicCurso->{"nombre"};
    #print $dic->{"nombre"}."\n";
    push (@profesores, $dic);
  }
  #print $profesores[0]->{"nombre"}."\n";
  return \@profesores;
}
################### FUNCIONES PARA OBETENR INFORMACION PERSONAL #####################
# Funcion que extrae informacion del usuario
sub datosAlumno {
  my $dni = $_[0];

  # Preparamos y ejecutamos la solicitud
  my $sth = $dbh->prepare("SELECT dni, nombre, apellido1, apellido2 FROM alumno WHERE dni = ?");

  $sth->execute($dni);

  # Obetenemos informacion
  my $dniRow = $sth->fetchrow_hashref;
  my %date = (
    nombre => $dniRow->{nombre},
    apellido1 => $dniRow->{apellido1},
    apellido2 => $dniRow->{apellido2}
  );

  return \%date;
}

sub respuestaJSON {
  my ($info) = @_;

  print $q->header(-type => 'application/json', -charset => 'utf-8');
  # print to_json($info);
  print encode_json($info);
  exit;
}

# Funcion que hace la conexion a la base de datos
sub connectDB {
  my $user = "alumno";
  my $pass = "pweb1";
  my $dsn = "DBI:MariaDB:database=pweb1;host=localhost";
  my $dbh = DBI->connect($dsn, $user, $pass) or die ("\e[1;31m No se pudo conectar!\n[0m]");
  return $dbh;
}


#################################################
#################################################
#EJECUCIÓN
#################################################
#################################################
# Convertimos los datos a json
#my @idTurnos = misTurnos($dni);
#original my $cursos = misCursos($dni);
if (! $dni) {
  $dni = 12345678;
}
my @turnos = misTurnos($dni);
my $cursos = misCursos($dni);
my $profesores = misProfesores(@turnos);
##my $json_data = respuestaJSON($cursos);
if ($query eq "cursos") {
  respuestaJSON($cursos);
} elsif ($query eq "profesores") {
  respuestaJSON($profesores);
}

else {
  print $q->header(-type => 'text/html', -charset => 'UTF-8');
  print<<AULAVIRTUAL;
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title></title>
</head>
<body>
  <h1>Bienvenido a tu aula virtual</h1>
  <i>Chara no tiene aula virtual</i>
</body>
</html>
AULAVIRTUAL
}
