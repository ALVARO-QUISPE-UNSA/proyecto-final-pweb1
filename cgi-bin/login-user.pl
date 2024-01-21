#!/usr/bin/perl
use lib "/home/alumno/perl5/lib/perl5";
use strict;
use warnings;
use CGI;
use CGI::Session;
use DBI;
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

my $q = CGI->new;
my $dni = $q->param("dni");
my $password = $q->param("passw");
utf8::decode($password);
my $dbh = connectDB();

# Validamos las cadenas y despues los credenciales del usuario
if($dni =~ /^\d{8}$/ && $password =~ /^.{8,}$/ && userValidate($dni, $password)) {
  # Recuperamos los datos del usuario y creamos una sesion
  my @dates = dates($dni);
  my $session = CGI::Session->new();
  my $sessionId = $session->id;

  # Creamos datos clave valor para que puedan ser recuperados
  $session->param('uName', $dates[0]);
  $session->param('uSurname1', $dates[1]);
  $session->param('uSurname2', $dates[2]);
  $session->flush;

  print "Set-Cookie: sessionId=$sessionId; path=/\n";
  print $q->redirect('aulaVirtual-priv.pl');
} else {
  print $q->redirect('../login.html');
}


#Subrutina que comprueba el usuario y la contraseña
sub userValidate {
  my $dni = $_[0];
  my $password = $_[1];

  # Preparamos y ejecutamos la solicitud
  my $sth = $dbh->prepare("SELECT dni, password FROM users WHERE dni = ?");
  $sth->execute($dni);

  # Comprobamos los credenciales
  if (my $dniRow = $sth->fetchrow_hashref) {
    if ($password eq $dniRow->{password}) {
      return 1;
    }
  }
  return 0;
}

# Funcion que extrae informacion del usuario
sub dates {
  my $dni = $_[0];

  # Preparamos y ejecutamos la solicitud
  my $sth = $dbh->prepare("SELECT dni, nombre, apellido1, apellido2 FROM alumno WHERE dni = ?");
  $sth->execute($dni);

  # Obetenemos informacion
  my $dniRow = $sth->fetchrow_hashref;
  my @arr = ($dniRow->{nombre}, $dniRow->{apellido1}, $dniRow->{apellido1});
  return @arr;
}

# Funcion que hace la conexion a la base de datos
sub connectDB {
  my $user = "alumno";
  my $pass = "pweb1";
  my $dsn = "DBI:MariaDB:database=pweb1;host=localhost";
  return my $dbh = DBI->connect($dsn, $user, $pass) or die ("\e[1;31m No se pudo conectar!\n[0m]");
}
