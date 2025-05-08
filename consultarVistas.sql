--Consultar todos los libros disponibles para préstamo
SELECT * FROM vista_libros_disponibles;

--Mostrar el historial de préstamos de un usuario específico
SELECT *
FROM vista_historial_prestamos
WHERE id_usuario = 3;

--Consultar todas las multas pendientes de pago
SELECT * FROM vista_multas_activas;

--Ver los libros más prestados (ordenados por cantidad)
SELECT *
FROM vista_libros_mas_prestados
LIMIT 10;

--Ver usuarios con préstamos vencidos
SELECT *
FROM vista_usuarios_con_prestamos_vencidos;
