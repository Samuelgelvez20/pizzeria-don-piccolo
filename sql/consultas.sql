-- Consultas
USE pizzeria_don_piccolo;

-- 1. Clientes con pedidos entre dos fechas (BETWEEN).
SELECT
    c.id_cliente,
    c.nombre,
    p.id_pedido,
    p.fecha_hora,
    p.estado
FROM cliente c
INNER JOIN pedido p
    ON c.id_cliente = p.id_cliente
WHERE p.fecha_hora BETWEEN '2026-07-01' AND '2026-07-15'
ORDER BY p.fecha_hora;


-- 2. Pizzas más vendidas (GROUP BY y COUNT).
SELECT
    pi.nombre AS pizza,
    COUNT(dp.id_pizza) AS veces_vendida
FROM pizza pi
INNER JOIN detalle_pedido dp
    ON pi.id_pizza = dp.id_pizza
GROUP BY pi.id_pizza, pi.nombre
ORDER BY veces_vendida DESC;


-- 3. Pedidos por repartidor (JOIN).
SELECT
    r.id_repartidor,
    r.nombre AS repartidor,
    p.id_pedido,
    p.fecha_hora,
    p.estado
FROM repartidor r
INNER JOIN domicilio d
    ON r.id_repartidor = d.id_repartidor
INNER JOIN pedido p
    ON d.id_pedido = p.id_pedido
ORDER BY r.nombre, p.fecha_hora;


-- 4. Promedio de entrega por zona (AVG y JOIN).
SELECT
    r.zona,
    AVG(TIMESTAMPDIFF(MINUTE, d.hora_salida, d.hora_entrega)) AS promedio_entrega_minutos
FROM repartidor r
INNER JOIN domicilio d
    ON r.id_repartidor = d.id_repartidor
WHERE d.hora_salida IS NOT NULL
  AND d.hora_entrega IS NOT NULL
GROUP BY r.zona
ORDER BY promedio_entrega_minutos;


-- 5. Clientes que gastaron más de un monto (HAVING).
SELECT
    c.id_cliente,
    c.nombre,
    SUM(pa.valor) AS total_gastado
FROM cliente c
INNER JOIN pedido p
    ON c.id_cliente = p.id_cliente
INNER JOIN pago pa
    ON p.id_pedido = pa.id_pedido
GROUP BY c.id_cliente, c.nombre
HAVING SUM(pa.valor) > 100000
ORDER BY total_gastado DESC;

-- 6. Búsqueda por coincidencia parcial de nombre de pizza (LIKE).
SELECT *
FROM pizza
WHERE nombre LIKE '%Queso%';


-- 7. Subconsulta para obtener los clientes frecuentes (más de 5 pedidos mensuales).
SELECT *
FROM cliente
WHERE id_cliente IN (
    SELECT id_cliente
    FROM pedido
    WHERE YEAR(fecha_hora) = 2026
      AND MONTH(fecha_hora) = 7
    GROUP BY id_cliente
    HAVING COUNT(*) > 5
);