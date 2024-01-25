--Base de datos: academia
CREATE DATABASE academia;
USE academia;

-- Crear la tabla 'users'
CREATE TABLE users (
  dni INT(8) UNSIGNED NOT NULL,
  password VARCHAR(255) NOT NULL,
  PRIMARY KEY (dni),
  UNIQUE KEY (dni),
);

-- Crear la tabla 'alumno' con la relación a la tabla 'users'
CREATE TABLE alumno (
  dni INT(8) UNSIGNED NOT NULL,
  nombre VARCHAR(255) NOT NULL,
  apellido1 VARCHAR(255) NOT NULL,
  apellido2 VARCHAR(255) NOT NULL,
  telefono VARCHAR(15),
  email VARCHAR(255),
  PRIMARY KEY (dni),
  FOREIGN KEY (dni) REFERENCES users(dni)
);
