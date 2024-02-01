USE pweb1;
CREATE TABLE matricula (
  id_matricula INT AUTO_INCREMENT PRIMARY KEY,
  fecha_emision DATE NOT NULL,
  fecha_vencimiento DATE NOT NULL,
  costo DECIMAL(10, 2) NOT NULL,
  id_alumno INT,
  FOREIGN KEY (id_alumno) REFERENCES alumno(dni)
);

-- Crear la tabla aulas
CREATE TABLE aulas (
  id_aula INT AUTO_INCREMENT PRIMARY KEY,
  piso INT NOT NULL,
  codigo VARCHAR(50) NOT NULL
);
-- Crear la tabla curso
CREATE TABLE curso (
  id_curso INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);
-- Crear la tabla temas
CREATE TABLE temas (
  id_tema INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);
CREATE TABLE materiales (
  id_material INT AUTO_INCREMENT PRIMARY KEY,
  tipo VARCHAR(50) NOT NULL,
  nombre VARCHAR(100) NOT NULL
);
CREATE TABLE profesores (
  dni INT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido1 VARCHAR(50) NOT NULL,
  apellido2 VARCHAR(50) NOT NULL,
  telefono VARCHAR(15) NOT NULL,
  email VARCHAR(100) NOT NULL,
  experiencia VARCHAR(100),
  direccion VARCHAR(255)
);
-- Crear la tabla temas_por_curso
CREATE TABLE temas_por_curso (
  id_tema INT,
  id_curso INT,
  FOREIGN KEY (id_tema) REFERENCES temas(id_tema),
  FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
);
-- Crear la tabla turnos
CREATE TABLE turnos (
  id_turno INT AUTO_INCREMENT PRIMARY KEY,
  id_curso INT,
  id_aula INT,
  dni_profesor INT,
  hora_inicio TIME,
  hora_fin TIME,
  duracion INT, -- Duración en minutos
  FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
  FOREIGN KEY (id_aula) REFERENCES aulas(id_aula),
  FOREIGN KEY (dni_profesor) REFERENCES profesores(dni)
);
-- Crear la tabla turnos_alumno
CREATE TABLE turnos_alumno (
  dni_alumno INT,
  id_turno INT,
  FOREIGN KEY (dni_alumno) REFERENCES alumno(dni),
  FOREIGN KEY (id_turno) REFERENCES turnos(id_turno)
);
-- Crear tabla de materiales_por_temas
CREATE TABLE materiales_por_temas (
  id_tema INT,
  id_material INT,
  FOREIGN KEY (id_tema) REFERENCES temas(id_tema),
  FOREIGN KEY (id_material) REFERENCES materiales(id_material)
);
