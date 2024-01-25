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
