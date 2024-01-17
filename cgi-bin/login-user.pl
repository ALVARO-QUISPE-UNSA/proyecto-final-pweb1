#!/usr/bin/perl
use strict;
use warnings;
use CGI;
my $q = CGI->new;
my $dni = $q->param("dni");
my $password = $q->param("password");
print $q->header("text/html");

# Validamos las cadenas y despues los credenciales del usuario
if($dni =~ /^\d{8}$/ && $password =~ /^.{8,}$/) {
  my $userId = userValidate($dni, $password);
  # Si el valor es undef, entonces el if siguiente es false
  if ($userId) {
    my $session = CGI::Session->new;
    $session->param("userId", $userId);

    print $cgi->redirect("aulaVirtual-priv.cgi");
  }
} else {
  print $cgi->redirect("../login.html");
}

sub userValidate {
  my $dni = $_[0];
  my $password = $_[1];
  my $dsn = "DBI:MariaDB:database=pweb1;host=127.0.0.1"; # Falta cambiar a la base real xd
  my $dbh = DBI->connect($dsn, $user, $password) or die("Error: No se pudo conectar");;

  my $sth = $dbh->prepare("SELECT id, password FROM Users WHERE dni = ? ");
  $sth->execute($dni);

  if (my $dniRow = $sth->fetchrow_hashref) {
    # Verificamos la contraseña
    if ($password eq $dniRow->{password})) {
      # En este caso, el id sera el identificador para crear una sesion, podemos cambiarlo
      return $dniRow->{id};
    }
  }
  return undef;
}
