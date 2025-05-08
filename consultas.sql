-- Consultas Simples

-- 1. Listar todos los libros disponibles en la biblioteca
SELECT * FROM `libro` WHERE `stock` > 0;

-- 2. Mostrar el historial de préstamos de un usuario específico
-- Suponiendo que el id_usuario sea 1
SELECT 
  p.`id_prestamo`, 
  p.`fecha_prestamo`, 
  p.`fecha_devolucion`, 
  p.`estado`, 
  d.`id_libro`, 
  l.`titulo`
FROM `prestamo` p
JOIN `detalle_prestamo` d ON p.`id_prestamo` = d.`id_prestamo`
JOIN `libro` l ON d.`id_libro` = l.`id_libro`
WHERE p.`id_usuario` = 1;

-- 3. Obtener los libros más prestados en el último semestre
SELECT 
  l.`id_libro`, 
  l.`titulo`, 
  COUNT(d.`id_libro`) AS `cantidad_prestada`
FROM `detalle_prestamo` d
JOIN `prestamo` p ON d.`id_prestamo` = p.`id_prestamo`
JOIN `libro` l ON d.`id_libro` = l.`id_libro`
WHERE p.`fecha_prestamo` >= CURDATE() - INTERVAL 6 MONTH
GROUP BY l.`id_libro`, l.`titulo`
ORDER BY `cantidad_prestada` DESC;

-- Consultas Avanzadas (Álgebra Relacional)

-- 4. Determinar cuántos préstamos ha realizado cada tipo de usuario (estudiantes y profesores)
SELECT 
  u.`tipo_usuario`, 
  COUNT(p.`id_prestamo`) AS `cantidad_prestamos`
FROM `usuario` u
LEFT JOIN `prestamo` p ON u.`id_usuario` = p.`id_usuario`
GROUP BY u.`tipo_usuario`;

-- 5. Obtener la cantidad total de libros prestados por cada carrera universitaria
SELECT 
  u.`carrera_departamento`, 
  SUM(d.`cantidad`) AS `total_libros_prestados`
FROM `usuario` u
JOIN `prestamo` p ON u.`id_usuario` = p.`id_usuario`
JOIN `detalle_prestamo` d ON p.`id_prestamo` = d.`id_prestamo`
GROUP BY u.`carrera_departamento`;

-- 6. Listar los usuarios con multas activas y el monto total de sus multas
SELECT 
  u.`id_usuario`, 
  u.`nombre`, 
  u.`apellido`, 
  SUM(m.`monto`) AS `monto_total_multas`
FROM `usuario` u
JOIN `multa` m ON u.`id_usuario` = m.`id_usuario`
WHERE m.`estado` = 'pendiente'
GROUP BY u.`id_usuario`, u.`nombre`, u.`apellido`;

-- 7. Encontrar los libros que nunca han sido prestados
SELECT 
  l.`id_libro`, 
  l.`titulo`
FROM `libro` l
LEFT JOIN `detalle_prestamo` d ON l.`id_libro` = d.`id_libro`
WHERE d.`id_libro` IS NULL;

-- 8. Identificar a los usuarios que tienen préstamos vencidos y no han devuelto los libros
SELECT 
  u.`id_usuario`, 
  u.`nombre`, 
  u.`apellido`, 
  p.`id_prestamo`, 
  p.`fecha_prestamo`, 
  p.`fecha_devolucion`
FROM `usuario` u
JOIN `prestamo` p ON u.`id_usuario` = p.`id_usuario`
WHERE p.`fecha_devolucion` < CURDATE() AND p.`estado` = 'activo';
