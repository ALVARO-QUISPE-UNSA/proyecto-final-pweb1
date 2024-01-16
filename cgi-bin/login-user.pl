#!/usr/bin/perl
use strict;
use warnings;
use CGI;

my $q = CGI->new;
my $dni = $q->param("dni");
my $password = $q->param("password");
print $q->header("text/html");

# Verificamos un dni correcto y una constrasena de al menos 8 caracteres
if($dni =~ /^\d{8}$/ && $password =~ /^.{8,}$/) {
  print "Muy bien, pagaste tu mensualidad.\n";
} else {
  print "dni o contrasena invalida.\n";
}
