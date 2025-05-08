-- Datos de prueba para `libro`
INSERT INTO `libro` (`titulo`, `autor`, `editorial`, `anio_publicacion`, `categoria`, `stock`) VALUES
('Cien años de soledad', 'Gabriel García Márquez', 'Sudamericana', 1967, 'Novela', 5),
('La Odisea', 'Homero', 'Clásicos Griegos', 1998, 'Épica', 3),
('El Principito', 'Antoine de Saint-Exupéry', 'Salamandra', 1943, 'Fábula', 10),
('1984', 'George Orwell', 'Secker & Warburg', 1949, 'Distopía', 4),
('Clean Code', 'Robert C. Martin', 'Prentice Hall', 2008, 'Programación', 2);

-- Datos de prueba para `usuario`
INSERT INTO `usuario` (`nombre`, `apellido`, `email`, `telefono`, `tipo_usuario`, `carrera_departamento`) VALUES
('Ana', 'Martínez', 'ana.martinez@example.com', '3214567890', 'estudiante', 'Ingeniería de Sistemas'),
('Luis', 'Gómez', 'luis.gomez@example.com', '3106543210', 'profesor', 'Matemáticas'),
('Sofía', 'Ríos', 'sofia.rios@example.com', '3001234567', 'estudiante', 'Psicología'),
('Carlos', 'Pérez', 'carlos.perez@example.com', '3157654321', 'profesor', 'Física');

-- Datos de prueba para `prestamo`
INSERT INTO `prestamo` (`id_usuario`, `fecha_prestamo`, `fecha_devolucion`, `estado`) VALUES
(1, CURDATE() - INTERVAL 10 DAY, CURDATE() - INTERVAL 3 DAY, 'devuelto'),
(2, CURDATE() - INTERVAL 20 DAY, CURDATE() - INTERVAL 5 DAY, 'atrasado'),
(3, CURDATE() - INTERVAL 2 DAY, CURDATE() + INTERVAL 5 DAY, 'activo'),
(1, CURDATE() - INTERVAL 30 DAY, CURDATE() - INTERVAL 15 DAY, 'devuelto');

-- Datos de prueba para `detalle_prestamo`
INSERT INTO `detalle_prestamo` (`id_prestamo`, `id_libro`, `cantidad`) VALUES
(1, 1, 1),
(1, 3, 1),
(2, 2, 1),
(3, 3, 1),
(3, 5, 1),
(4, 4, 1);

-- Datos de prueba para `multa`
INSERT INTO `multa` (`id_usuario`, `monto`, `motivo`, `estado`) VALUES
(2, 15000.00, 'Devolución tardía', 'pendiente'),
(1, 5000.00, 'Libro dañado', 'pagada');
