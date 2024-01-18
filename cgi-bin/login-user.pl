#!/usr/bin/perl
# Esta direccion es para usar el modulo CGI::Session 
# use lib '/home/alumno/perl5/lib/perl5';
use strict;
use warnings;
use CGI;
# use CGI::Session;
use DBI;
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

my $q = CGI->new;
my $dni = $q->param("dni");
my $password = $q->param("passw");
utf8::decode($password);

# Validamos las cadenas y despues los credenciales del usuario
if($dni =~ /^\d{8}$/ && $password =~ /^.{8,}$/ && userValidate($dni, $password)) {
  # my $session = CGI::Session->new($q);
  # $session->param('userDni', $dni);
  # $session->header($q);
  # En el primer CGI
  print $q->redirect(-uri => 'aulaVirtual-priv.pl', -method => 'POST', -query => "dni=$dni");
} else {
  print $q->redirect('../login.html');
}

sub userValidate {
  my $dni = $_[0];
  my $password = $_[1];
  
  # Conexion a la base de datos  
  my $user= 'alumno';
  my $passw = 'pweb1';
  my $dsn = "DBI:MariaDB:database=pweb1;host=localhost";
  my $dbh = DBI->connect($dsn, $user, $passw) or die("Error: No se pudo conectar");;

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
  $sth->finish;
  $dbh->disconnect;
}
