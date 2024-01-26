--Base de datos: academia
--CREATE DATABASE academia;
USE pweb1;

-- Crear la tabla 'users'
CREATE TABLE users (
  dni INT NOT NULL,
  password VARCHAR(255) NOT NULL,
  PRIMARY KEY (dni),
  UNIQUE KEY (dni)
);

-- Crear la tabla 'alumno' con la relación a la tabla 'users'
CREATE TABLE alumno (
  dni INT NOT NULL,
  nombre VARCHAR(255) NOT NULL,
  apellido1 VARCHAR(255) NOT NULL,
  apellido2 VARCHAR(255) NOT NULL,
  telefono VARCHAR(15),
  email VARCHAR(255),
  PRIMARY KEY (dni),
  FOREIGN KEY (dni) REFERENCES users(dni)
);
-- Añadir usuarios a la tabla 'users'
INSERT INTO users (dni, password) VALUES
(12345678, 'contraseña1'),
(23456789, 'contraseña2'),
(34567890, 'contraseña3'),
(45678901, 'contraseña4'),
(56789012, 'contraseña5');

-- Añadir alumnos a la tabla 'alumno' con referencia a la tabla 'users' INSERT INTO alumno (dni, nombre, apellido1, apellido2, telefono, email) VALUES (12345678, 'Nombre1', 'Apellido1', 'Apellido2', '123456789', 'correo1@example.com'),
(23456789, 'Nombre2', 'Apellido1', 'Apellido2', '234567890', 'correo2@example.com'),
(34567890, 'Nombre3', 'Apellido1', 'Apellido2', '345678901', 'correo3@example.com'),
(45678901, 'Nombre4', 'Apellido1', 'Apellido2', '456789012', 'correo4@example.com'),
(56789012, 'Nombre5', 'Apellido1', 'Apellido2', '567890123', 'correo5@example.com');
