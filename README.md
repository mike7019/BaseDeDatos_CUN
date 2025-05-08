# Sistema de Gestión de Biblioteca

Este proyecto implementa una base de datos para un sistema de gestión de biblioteca utilizando MySQL, diseñado para administrar libros, usuarios, préstamos y multas en un entorno académico.

## Estructura del Proyecto

El sistema está desplegado usando Docker Compose y cuenta con una base de datos MySQL con las siguientes tablas:

- `libro`: Almacena información de los libros disponibles
- `usuario`: Registra los datos de estudiantes y profesores
- `prestamo`: Gestiona los préstamos realizados
- `detalle_prestamo`: Detalla los libros incluidos en cada préstamo
- `multa`: Registra las sanciones por devoluciones tardías o daños

## Requisitos

- Docker
- Docker Compose
- DBeaver (Database Client)

## Instalación y Configuración

1. Creamos una carpeta en un directorio preferido y clonamos con Git este repositorio usando una consola de comandos:

```bash
git clone https://github.com/mike7019/BaseDeDatos_CUN
cd BaseDeDatos_CUN
```

2. Inicie los servicios con Docker Compose:

```bash
docker-compose up -d
```

3. Conéctese a la base de datos MySQL:

```bash
docker exec -it my-mysql mysql -u user -puser biblioteca
```

4. Ejecute los scripts SQL para crear las tablas y cargar datos de prueba (si no se cargaron automáticamente).

## Estructura de la Base de Datos

### Tabla `libro`

```sql
CREATE TABLE `libro` (
  `id_libro` INT PRIMARY KEY AUTO_INCREMENT,
  `titulo` VARCHAR(255) NOT NULL,
  `autor` VARCHAR(255),
  `editorial` VARCHAR(255),
  `anio_publicacion` YEAR,
  `categoria` VARCHAR(100),
  `stock` INT NOT NULL
);
```

### Tabla `usuario`

```sql
CREATE TABLE `usuario` (
  `id_usuario` INT PRIMARY KEY AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `apellido` VARCHAR(100) NOT NULL,
  `email` VARCHAR(255) UNIQUE NOT NULL,
  `telefono` VARCHAR(15),
  `tipo_usuario` ENUM('estudiante', 'profesor'),
  `carrera_departamento` VARCHAR(255)
);
```

### Tabla `prestamo`

```sql
CREATE TABLE `prestamo` (
  `id_prestamo` INT PRIMARY KEY AUTO_INCREMENT,
  `id_usuario` INT,
  `fecha_prestamo` DATE,
  `fecha_devolucion` DATE,
  `estado` ENUM('activo', 'devuelto', 'atrasado'),
  FOREIGN KEY (`id_usuario`) REFERENCES `usuario`(`id_usuario`) ON DELETE CASCADE
);
```

### Tabla `detalle_prestamo`

```sql
CREATE TABLE `detalle_prestamo` (
  `id_prestamo` INT,
  `id_libro` INT,
  `cantidad` INT,
  PRIMARY KEY (`id_prestamo`, `id_libro`),
  FOREIGN KEY (`id_prestamo`) REFERENCES `prestamo`(`id_prestamo`) ON DELETE CASCADE,
  FOREIGN KEY (`id_libro`) REFERENCES `libro`(`id_libro`) ON DELETE CASCADE
);
```

### Tabla `multa`

```sql
CREATE TABLE `multa` (
  `id_multa` INT PRIMARY KEY AUTO_INCREMENT,
  `id_usuario` INT,
  `monto` DECIMAL(8,2),
  `motivo` VARCHAR(255),
  `estado` ENUM('pendiente', 'pagada'),
  FOREIGN KEY (`id_usuario`) REFERENCES `usuario`(`id_usuario`) ON DELETE CASCADE
);
```

## Consultas SQL Disponibles

### Consultas Básicas

1. Listar todos los libros disponibles en la biblioteca
2. Mostrar el historial de préstamos de un usuario específico
3. Obtener los libros más prestados en el último semestre

### Consultas Avanzadas

4. Determinar cuántos préstamos ha realizado cada tipo de usuario
5. Obtener la cantidad total de libros prestados por cada carrera universitaria
6. Listar los usuarios con multas activas y el monto total de sus multas
7. Encontrar los libros que nunca han sido prestados
8. Identificar a los usuarios que tienen préstamos vencidos

## Datos de Prueba

El sistema incluye datos de prueba para todas las tablas:

- 5 libros con distintas categorías
- 4 usuarios (2 estudiantes y 2 profesores)
- 4 préstamos con diferentes estados
- 6 detalles de préstamo
- 2 multas (una pagada y otra pendiente)

## Diagrama Entidad-Relación

```sh
+----------+       +------------+       +-----------------+
|  LIBRO   |-------|  DETALLE   |-------|    PRESTAMO     |
+----------+       |  PRESTAMO  |       +-----------------+
                   +------------+              |
                                               |
                                        +------+------+
                                        |   USUARIO   |
                                        +------+------+
                                               |
                                        +------+------+
                                        |    MULTA    |
                                        +-------------+
```

## Uso

Ejemplos de uso:

```sql
-- Consultar libros disponibles
SELECT * FROM `libro` WHERE `stock` > 0;

-- Ver préstamos de un usuario
SELECT p.*, l.titulo FROM `prestamo` p 
JOIN `detalle_prestamo` d ON p.`id_prestamo` = d.`id_prestamo`
JOIN `libro` l ON d.`id_libro` = l.`id_libro`
WHERE p.`id_usuario` = 1;
```

## Configuración de MySQL

El servicio MySQL está configurado con:

- Usuario: user
- Contraseña: user
- Base de datos: biblioteca
- Puerto: 3306
- Autenticación: mysql_native_password

## Contribución

Para contribuir a este proyecto:

1. Haga un fork del repositorio
2. Cree una rama para su característica
3. Envíe un pull request

## Licencia

Este proyecto está bajo la Licencia MIT.