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
my $name = $session->param("uName");
my $surname1 = $session->param("uSurname1");
my $surname2 = $session->param("uSurname2");

print $q->header(-type => 'text/html', -charset => 'UTF-8');
print<<AULAVIRTUAL;
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Aula Virtual</title>
  <!-- <link rel="stylesheet" href="../css/styles.css"> -->
</head>
<body>

<section>
  <div>
    <p>Lo que sea</p>
  </div>
  <div>
    <p>Cursos</p>
  </div>
  <div>
    <p>Profitos</p>
  </div>
  <ul>
    <li>Contacto 1</li>
    <li>Contacto 2</li>
    <li>Contacto 3</li>
    <li>Contacto 4</li>
  </ul>
</section>

<section>
  <div>
    <h3> Bienvenido $name $surname1 $surname2 </h3>
  </div>
  <!--<script src="../.js"></script> -->
</section>

</body>
</html>
AULAVIRTUAL

