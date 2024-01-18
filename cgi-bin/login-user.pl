#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;
binmode(STDOUT, ":utf8");
binmode(STDIN, ":utf8");

my $q = CGI->new;
my $dni = $q->param("dni");
my $password = $q->param("passw");
utf8::decode($password);

# Validamos las cadenas y despues los credenciales del usuario
if($dni =~ /^\d{8}$/ && $password =~ /^.{8,}$/ && userValidate($dni, $password)) {
  print $q->header('text/html');

  print <<HTML
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300&family=Nanum+Gothic+Coding&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="styles/redirect.css">
    <title>Inicia sesión - Grupo Piensa</title>
  </head>
  <body>
    <div class="wrapper">
      <h1>Redirigiendo</h1>
    </div>
    <form id="redirect" action="aulaVirtual-priv.pl" method="POST">
      <input type="hidden" name="dni" value="$dni">
      <input type="hidden" name="passw" value="$password">
    </form>
    <script>
      setTimeout(function(){
        document.getElementById("redirect").submit();
}, 2000);
    </script>
  </body>
HTML
} else {
  print $q->redirect('../login.html');
}


#Subrutina que comprueba el usuario y la contraseña

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
