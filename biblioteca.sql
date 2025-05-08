CREATE TABLE `libro` (
  `id_libro` INT PRIMARY KEY AUTO_INCREMENT,
  `titulo` VARCHAR(255) NOT NULL,
  `autor` VARCHAR(255),
  `editorial` VARCHAR(255),
  `anio_publicacion` YEAR,
  `categoria` VARCHAR(100),
  `stock` INT NOT NULL
);

CREATE TABLE `usuario` (
  `id_usuario` INT PRIMARY KEY AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `apellido` VARCHAR(100) NOT NULL,
  `email` VARCHAR(255) UNIQUE NOT NULL,
  `telefono` VARCHAR(15),
  `tipo_usuario` ENUM('estudiante', 'profesor'),
  `carrera_departamento` VARCHAR(255)
);

CREATE TABLE `prestamo` (
  `id_prestamo` INT PRIMARY KEY AUTO_INCREMENT,
  `id_usuario` INT,
  `fecha_prestamo` DATE,
  `fecha_devolucion` DATE,
  `estado` ENUM('activo', 'devuelto', 'atrasado'),
  FOREIGN KEY (`id_usuario`) REFERENCES `usuario`(`id_usuario`) ON DELETE CASCADE
);

CREATE TABLE `detalle_prestamo` (
  `id_prestamo` INT,
  `id_libro` INT,
  `cantidad` INT,
  PRIMARY KEY (`id_prestamo`, `id_libro`),
  FOREIGN KEY (`id_prestamo`) REFERENCES `prestamo`(`id_prestamo`) ON DELETE CASCADE,
  FOREIGN KEY (`id_libro`) REFERENCES `libro`(`id_libro`) ON DELETE CASCADE
);

CREATE TABLE `multa` (
  `id_multa` INT PRIMARY KEY AUTO_INCREMENT,
  `id_usuario` INT,
  `monto` DECIMAL(8,2),
  `motivo` VARCHAR(255),
  `estado` ENUM('pendiente', 'pagada'),
  FOREIGN KEY (`id_usuario`) REFERENCES `usuario`(`id_usuario`) ON DELETE CASCADE
);
