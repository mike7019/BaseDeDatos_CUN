-- 1. Vista de libros disponibles
CREATE VIEW vista_libros_disponibles AS
SELECT id_libro, titulo, autor, editorial, anio_publicacion, categoria, stock
FROM libro
WHERE stock > 0;

-- 2. Vista de historial de préstamos por usuario
CREATE VIEW vista_historial_prestamos AS
SELECT 
  u.id_usuario,
  CONCAT(u.nombre, ' ', u.apellido) AS nombre_usuario,
  p.id_prestamo,
  p.fecha_prestamo,
  p.fecha_devolucion,
  p.estado
FROM usuario u
JOIN prestamo p ON u.id_usuario = p.id_usuario;

-- 3. Vista de multas activas
CREATE VIEW vista_multas_activas AS
SELECT 
  m.id_multa,
  u.id_usuario,
  CONCAT(u.nombre, ' ', u.apellido) AS nombre_usuario,
  m.monto,
  m.motivo
FROM multa m
JOIN usuario u ON m.id_usuario = u.id_usuario
WHERE m.estado = 'pendiente';

-- 4. Vista de libros más prestados
CREATE VIEW vista_libros_mas_prestados AS
SELECT 
  l.id_libro,
  l.titulo,
  COUNT(dp.id_libro) AS total_prestamos
FROM detalle_prestamo dp
JOIN libro l ON dp.id_libro = l.id_libro
GROUP BY l.id_libro, l.titulo
ORDER BY total_prestamos DESC;

-- 5. Vista de usuarios con préstamos vencidos
CREATE VIEW vista_usuarios_con_prestamos_vencidos AS
SELECT 
  u.id_usuario,
  CONCAT(u.nombre, ' ', u.apellido) AS nombre_usuario,
  p.id_prestamo,
  p.fecha_prestamo,
  p.fecha_devolucion,
  p.estado
FROM usuario u
JOIN prestamo p ON u.id_usuario = p.id_usuario
WHERE p.estado = 'atrasado';