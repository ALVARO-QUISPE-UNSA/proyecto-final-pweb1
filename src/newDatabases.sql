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
