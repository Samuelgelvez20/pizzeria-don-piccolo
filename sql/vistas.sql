-- vistas
-- 1. Vista de resumen de pedidos por cliente (nombre del cliente, cantidad de pedidos, total gastado).
CREATE VIEW vista_resumen_pedidos_cliente AS
SELECT
    c.id_cliente,
    c.nombre,
    COUNT(p.id_pedido) AS cantidad_pedidos,
    SUM(pa.valor) AS total_gastado
FROM cliente c
INNER JOIN pedido p
    ON c.id_cliente = p.id_cliente
INNER JOIN pago pa
    ON p.id_pedido = pa.id_pedido
GROUP BY c.id_cliente, c.nombre;


-- 2. Vista de desempeño de repartidores (número de entregas, tiempo promedio, zona).
CREATE VIEW vista_desempeno_repartidores AS
SELECT
    r.id_repartidor,
    r.nombre,
    r.zona,
    COUNT(d.id_domicilio) AS numero_entregas,
    AVG(
        TIMESTAMPDIFF(
            MINUTE,
            d.hora_salida,
            d.hora_entrega
        )
    ) AS tiempo_promedio_minutos
FROM repartidor r
INNER JOIN domicilio d
    ON r.id_repartidor = d.id_repartidor
GROUP BY
    r.id_repartidor,
    r.nombre,
    r.zona;


-- 3. Vista de stock de ingredientes por debajo del mínimo permitido.
CREATE VIEW vista_stock_bajo AS
SELECT *
FROM ingrediente
WHERE stock <= stock_minimo;