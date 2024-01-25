USE pweb1;
INSERT INTO matricula (fecha_emision, fecha_vencimiento, costo, id_alumno)
VALUES
('2024-01-01', '2024-12-31', 100.00, (SELECT dni FROM alumno WHERE dni = 12345678)),
('2024-01-15', '2024-12-31', 120.00, (SELECT dni FROM alumno WHERE dni = 23456789)),
('2024-02-01', '2024-12-31', 90.00, (SELECT dni FROM alumno WHERE dni = 34567890)),
('2024-02-15', '2024-12-31', 110.00, (SELECT dni FROM alumno WHERE dni = 45678901)),
('2024-03-01', '2024-12-31', 80.00, (SELECT dni FROM alumno WHERE dni = 56789012));
-- LLenar tabla de aulas:
INSERT INTO aulas (piso, codigo) VALUES
(1, 'A101'),
(2, 'B201'),
(1, 'A102'),
(3, 'C301');
-- Insertar datos de cursos
INSERT INTO curso (nombre) VALUES
('Cálculo 1'),
('Matemática Básica'),
('Física 1');
-- Insertar datos de temas
INSERT INTO temas (nombre) VALUES
('Funciones, Límites y Continuidad'),
('Derivada y sus Aplicaciones'),
('La Integral, Técnicas de Integración'),
('Números Reales'),
('Funciones Reales'),
('Plano Cartesiano'),
('Vectores en el Plano'),
('Magnitudes Físicas y Vectores'),
('Movimiento en una Dimensión'),
('Movimiento en Dos y Tres Dimensiones'),
('Dinámica de la Partícula'),
('Cantidad de Movimiento Lineal y Colisiones');
-- Insertar datos de materiales
INSERT INTO materiales (tipo, nombre) VALUES
('Libro', 'Guía de la UNSA de Cálculo'),
('Libro', 'Trascendentes Tempranas, Stewart'),
('Libro', 'Física Universitaria Libro de Young y Freedman'),
('Libro', 'Matemática Básica Eduardo Espinoza Ramos');
-- Insertar datos de profesores
INSERT INTO profesores (dni, nombre, apellido1, apellido2, telefono, email, experiencia, direccion)
VALUES
(11111111, 'Profesor1', 'Apellido1', 'Apellido2', '123456789', 'profesor1@example.com', 'Experiencia en Cálculo y Trascendentes Tempranas', 'Dirección1'),
(22222222, 'Profesor2', 'Apellido1', 'Apellido2', '234567890', 'profesor2@example.com', 'Especialista en Matemática Básica', 'Dirección2'),
(33333333, 'Profesor3', 'Apellido1', 'Apellido2', '345678901', 'profesor3@example.com', 'Amplia experiencia en Física Universitaria', 'Dirección3'),
(44444444, 'Profesor4', 'Apellido1', 'Apellido2', '456789012', 'profesor4@example.com', 'Experto en Movimiento y Dinámica', 'Dirección4'),
(55555555, 'Profesor5', 'Apellido1', 'Apellido2', '567890123', 'profesor5@example.com', 'Especialización en Cantidad de Movimiento Lineal y Colisiones', 'Dirección5');
-- Insertar datos en temas_por_curso
INSERT INTO temas_por_curso (id_tema, id_curso)
VALUES
(1, 1),  -- Cálculo 1
(2, 1),  -- Cálculo 1
(3, 1),  -- Cálculo 1
(5, 2),  -- Matemática Básica
(4, 2),  -- Matemática Básica
(7, 2),  -- Vectores en el Plano
(10, 3), -- Movimiento en una Dimensión
(11, 3), -- Movimiento en Dos y Tres Dimensiones
(12, 3), -- Dinámica de la Partícula
(6, 3),  -- Física 1
(3, 3),  -- Física 1
(8, 3), -- Física 1
(9, 3); -- Física 1


-- Insertar datos en la tabla turnos
INSERT INTO turnos (id_curso, id_aula, dni_profesor, hora_inicio, hora_fin, duracion)
VALUES
(1, 1, 11111111, '08:00:00', '10:00:00', 120),  -- Cálculo 1, Aula 1, Profesor1, 8:00 AM - 10:00 AM, 2 horas
(2, 2, 22222222, '10:30:00', '12:30:00', 120),  -- Matemática Básica, Aula 2, Profesor2, 10:30 AM - 12:30 PM, 2 horas
(3, 3, 33333333, '14:00:00', '16:00:00', 120),  -- Física 1, Aula 3, Profesor3, 2:00 PM - 4:00 PM, 2 horas
(1, 4, 44444444, '19:00:00', '21:00:00', 120);  -- Cálculo 1, Aula 1, Profesor5, 7:00 PM - 9:00 PM, 2 horas
-- Insertar datos en la talba turnos_alumno 
INSERT INTO turnos_alumno (dni_alumno, id_turno)
VALUES 
(12345678, 1),  -- Alumno1, Cálculo 1
(23456789, 1),  -- Alumno2, Cálculo 1
(34567890, 2),  -- Alumno3, Matemática Básica
(45678901, 2),  -- Alumno4, Matemática Básica
(56789012, 3);  -- Alumno5, Física 1
-- Insertar datos
INSERT INTO materiales_por_temas (id_tema, id_material) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4);
