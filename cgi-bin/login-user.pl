#!/usr/bin/perl
# Esta importacion solo es para usar el modulo CGI::Session, como en la maquina 
# virtual no tengo permisos de root, entonces lo instale en el home
#use lib "$ENV{HOME}/perl5/lib/perl5";

use strict;
use warnings;
use CGI;
#use CGI::Session;
use DBI;
#binmode(STDOUT, ":utf8");
#binmode(STDIN, ":utf8");

my $q = CGI->new;
my $dni = $q->param("dni");
my $password = $q->param("passw");
#utf8::decode($password);

print $q->header(-type => 'text/html', -charset => 'UTF-8');
print "<p>hol mundo</p>";
## print "$dni\n";
## print "$password\n";
#
## Validamos las cadenas y despues los credenciales del usuario
#if($dni =~ /^\d{8}$/ && $password =~ /^.{8,}$/) {
#  # print "Si ingresa, cadenas correctas\n";
#  my $userDni = userValidate($dni, $password);
#
#  # Si el valor es undef, entonces el if siguiente es false
#  if (defined $userDni) {
#    my $session = CGI::Session->new;
#    $session->param("userDni", $userDni);
#
#    # print "Credenciales correctos\n";
#    print $q->redirect("aulaVirtual-priv.pl");
#  } else {
#    # print "credenciales incorrectos\n"; 
#    print $q->redirect("../login.html");
#  }
#} else {
#  # print "Cadenas incorrectas\n";
#  print $q->redirect("../login.html");
#}
#
#sub userValidate {
#  my $dni = $_[0];
#  my $password = $_[1];
#  
#  # Conexion a la base de datos
#  # En este caso, estoy conectando a mi servidor. Si desean probar, lo cambian  
#  my $user = 'alumno';
#  my $pass = 'pweb1';
#  my $dsn = "DBI:MariaDB:database=pweb1;host=localhost";
#  my $dbh = DBI->connect($dsn, $user, $pass) or die("Error: No se pudo conectar");;
#  # print "Conexion exitosa\n";
#
#  # Preparamos y ejecutamos la solicitud
#  my $sth = $dbh->prepare("SELECT dni, password FROM users WHERE dni = ?");
#  $sth->execute($dni);
#  # print "Consulta exitosa\n";
#
#  # Comprobamos los credenciales
#  if (my $dniRow = $sth->fetchrow_hashref) {
#    # print "$dniRow->{password}\n";
#    # Verificamos la contraseña
#    if ($password eq $dniRow->{password}) {
#      # print "constrasenas iguales\n";
#      return $dniRow->{dni};
#    }
#  }
#  $sth->finish;
#  $dbh->disconnect;
#  return undef;
#}
