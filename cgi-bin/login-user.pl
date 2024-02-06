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
if(userValidate($dni, $password)) {
  my $session = CGI::Session->new();
  my $sessionId = $session->id;

  # Creamos datos clave valor para que puedan ser recuperados
  $session->param('dni', $dni);
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

# Funcion que hace la conexion a la base de datos
sub connectDB {
  my $user = "alumno";
  my $pass = "pweb1";
  my $dsn = "DBI:MariaDB:database=pweb1;host=localhost";
  my $dbh = DBI->connect($dsn, $user, $pass) or die ("\e[1;31m No se pudo conectar!\n[0m]");
  return $dbh;
}
