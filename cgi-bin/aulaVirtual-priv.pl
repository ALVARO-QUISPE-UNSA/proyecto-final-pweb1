#!/usr/bin/perl
use warnings;
use strict;
use CGI;
use DBI;
my $q = new CGI;
#Conección DB
#  sub conectionDB () {
#  my $user = $_[0];
#  my $password = $_[1];
#  my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.215.149";
  #Deberíamos hacer una rutina 
  #que me conecte al local host, pues desde ahí
  #accedemos a la base de datos,
  #En java se ponía eso creo, 
  #así nos olvidamos de tener que poner la dirección ip

  # dbh se encarga de hacer consultas
# return DBI->connect($dsn, $user, $password) or die ("\e[1;31m No se pudo conectar!\n[0m]");
  #}
  #my $dbh = conectionDB("alumno", "pweb1");

#######CAPUTAR VARIABLES
  #my $dni = "12345678";
  #my $password = "contraseña1";

#MAIN-----------------------
print $q->header(-type => 'text/html', -charset => 'UTF-8');
print<<OJOSAZULES;
Estoy loguwadoooodkoajvbehvbhfbv
OJOSAZULES
