# Sistema de Gestión de Biblioteca

Este proyecto implementa una base de datos para un sistema de gestión de biblioteca utilizando MySQL, diseñado para administrar libros, usuarios, préstamos y multas en un entorno académico.

## Informe de Diseño y Consultas de la Base de Datos

### 1. Introducción
Este informe documenta el diseño de la base de datos para un sistema de gestión de biblioteca, incluyendo las estructuras de las tablas, relaciones, consultas SQL, vistas para simplificar y restringir el acceso a los datos, y su representación en álgebra relacional.

### 2. Modelo de Base de Datos Relacional
**Tablas:**
* **libro(id_libro, titulo, autor, editorial, anio_publicacion, categoria, stock)**
* **usuario(id_usuario, nombre, apellido, email, telefono, tipo_usuario, carrera_departamento)**
* **prestamo(id_prestamo, id_usuario, fecha_prestamo, fecha_devolucion, estado)**
* **detalle_prestamo(id_prestamo, id_libro, cantidad)**
* **multa(id_multa, id_usuario, monto, motivo, estado)**

**Relaciones:**
* Cada *usuario* puede tener muchos *préstamos* (1:N).
* Cada *préstamo* puede incluir varios *libros* (N:M), implementado mediante la tabla *detalle_prestamo*.
* Cada *usuario* puede tener muchas *multas* (1:N).

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

## Instalación y Configuración

1. Clone este repositorio:
   ```bash
   git clone https://github.com/tu-usuario/biblioteca-db.git
   cd biblioteca-db
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

### 3. Consultas SQL y Vistas

#### 3.1 Vistas
* **vista_libros_disponibles**: Lista solo libros con stock > 0.
* **vista_historial_prestamos**: Historial de préstamos de cada usuario.
* **vista_multas_activas**: Multas cuyo estado es "pendiente".
* **vista_libros_mas_prestados**: Libros ordenados por la cantidad de veces prestados.
* **vista_usuarios_con_prestamos_vencidos**: Usuarios con préstamos en estado "atrasado".

#### 3.2 Consultas de ejemplo con Álgebra Relacional:

* **Listar libros disponibles**:
```sql
SELECT * FROM vista_libros_disponibles;
```
**Álgebra relacional:** σ_stock>0_(libro)

* **Historial de préstamos de un usuario**:
```sql
SELECT * FROM vista_historial_prestamos WHERE id_usuario = 3;
```
**Álgebra relacional:** σ_id_usuario=3_(usuario ⨝ prestamo)

* **Multas pendientes:**
```sql
SELECT * FROM vista_multas_activas;
```
**Álgebra relacional:** σ_estado='pendiente'_(multa ⨝ usuario)

* **Top 10 libros más prestados:**
```sql
SELECT * FROM vista_libros_mas_prestados LIMIT 10;
```
**Álgebra relacional:** γ_id_libro,titulo;COUNT(id_libro)_(detalle_prestamo ⨝ libro)

* **Usuarios con préstamos vencidos:**
```sql
SELECT * FROM vista_usuarios_con_prestamos_vencidos;
```
**Álgebra relacional:** σ_estado='atrasado'_(usuario ⨝ prestamo)

## Datos de Prueba

El sistema incluye datos de prueba para todas las tablas:
- 5 libros con distintas categorías
- 4 usuarios (2 estudiantes y 2 profesores)
- 4 préstamos con diferentes estados
- 6 detalles de préstamo
- 2 multas (una pagada y otra pendiente)

## Diagrama Entidad-Relación

![Image](https://github.com/user-attachments/assets/db4f3330-6d4e-4315-b8b6-3db8a8d1c49a)

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

### 4. Usuario de Consulta
Se ha creado el usuario `usuario_consulta` con acceso solo a las vistas:

```sql
CREATE USER 'usuario_consulta'@'%' IDENTIFIED BY 'consulta123';
GRANT SELECT ON biblioteca.vista_* TO 'usuario_consulta'@'%';
```

Esto asegura acceso restringido a datos sensibles, como multas o préstamos, sin exponer directamente las tablas.

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

### 5. Conclusión
El diseño implementa un modelo relacional claro y normalizado. El uso de vistas mejora la seguridad y simplifica las consultas frecuentes. La representación en álgebra relacional valida la correspondencia lógica con las operaciones realizadas en SQL.

## Licencia

Este proyecto está bajo la Licencia MIT.
