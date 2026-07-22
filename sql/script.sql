USE pizzeria_don_piccolo;

-- SE ELIMINAN LAS TABLAS DOMICILIO Y REPARTIDOR PARA REALIZAR SU MEJORA.
DROP TABLE domicilio;
DROP TABLE repartidor;

-- CREACION DE TABLAS DOMICILIO Y REPARTIDOR.
-- Tabla repartidor
CREATE TABLE repartidor (
    id_repartidor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(10), -- se le agrega el telefono del repartidor como se solicito.
    zona VARCHAR(100) NOT NULL,
    estado ENUM('Activo','Inactivo') NOT NULL
);

-- Tabla domicilios
CREATE TABLE domicilio (
    id_domicilio INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_repartidor INT NOT NULL,

    hora_salida DATETIME,
    hora_entrega DATETIME,
    -- se le agrega el estado del domicilio como se solicito.
    estado ENUM('en_ruta','entregado','cancelado'),
    distancia DECIMAL(5,2),
    costo_envio DECIMAL(10,2),

    FOREIGN KEY (id_pedido)
        REFERENCES pedido(id_pedido),

    FOREIGN KEY (id_repartidor)
        REFERENCES repartidor(id_repartidor)
);

-- INSERCION DE DATOS DE PRUEBA.
-- Datos tabla repartidores
INSERT INTO repartidor (nombre, telefono, zona, estado) VALUES
('Luis Moreno','3156678515','Norte','Activo'),
('Camilo Díaz','3515688625','Sur','Activo'),
('Jorge Rojas','3466468752','Centro','Activo'),
('Kevin García','3463315542','Occidente','Activo'),
('Felipe Vargas','3465814540','Oriente','Activo');


-- Datos tabla domicilio
INSERT INTO domicilio
(id_pedido, id_repartidor, hora_salida, hora_entrega, estado, distancia, costo_envio)
VALUES
(1,1,'2026-07-01 18:50:00','2026-07-01 19:15:00','en_ruta',4.5,5000),
(2,2,'2026-07-03 19:15:00','2026-07-03 19:40:00','entregado',3.2,4000),
(3,4,'2026-07-05 20:20:00','2026-07-05 20:45:00','entregado',6.5,7000),
(4,1,'2026-07-07 19:00:00','2026-07-07 19:30:00','en_ruta',5.0,6000),
(6,5,'2026-07-11 19:35:00','2026-07-11 20:00:00','cancelado',2.8,4000),
(7,3,'2026-07-02 18:55:00','2026-07-02 19:20:00','cancelado',7.1,8000),
(8,4,'2026-07-04 20:10:00','2026-07-04 20:35:00','entregado',3.8,5000),
(10,1,'2026-07-08 21:20:00','2026-07-08 21:45:00','en_ruta',4.3,5000),
(11,5,'2026-07-10 18:20:00','2026-07-10 18:45:00','entregado',6.0,7000),
(13,2,'2026-07-13 20:25:00','2026-07-13 20:50:00','cancelado',2.5,4000),
(14,4,'2026-07-14 19:25:00','2026-07-14 19:50:00','en_ruta',5.5,6000),
(15,3,'2026-07-15 20:35:00','2026-07-15 21:00:00','entregado',4.0,5000),
(16,1,'2026-07-16 19:05:00','2026-07-16 20:30:00','entregado',8.2,9000),
(18,5,'2026-07-18 19:55:00','2026-07-18 20:20:00','en_ruta',3.5,5000),
(19,2,'2026-07-19 20:35:00','2026-07-19 21:00:00','cancelado',4.7,6000),
(20,3,'2026-07-20 18:50:00','2026-07-20 19:15:00','en_ruta',5.9,7000);

-- CONSULTAS
-- Consulta de entregas realizadas por cada repartidor.
SELECT
    r.nombre AS repartidor,
    COUNT(d.estado) AS entregas_realizadas
FROM repartidor r
INNER JOIN domicilio d
    ON r.id_repartidor = d.id_repartidor
WHERE d.estado = 'entregado'
GROUP BY r.nombre;

-- Consulta de pedidos demorados.
SELECT 
	p.id_pedido,
    d.hora_salida,
    d.hora_entrega
FROM pedido p
JOIN domicilio d
ON p.id_pedido = d.id_pedido
WHERE TIMESTAMPDIFF(MINUTE, hora_salida, hora_entrega) > 40; 

-- Consulta de repartidores activos sin entregas.
SELECT
	r.nombre,
    r.estado
FROM repartidor r
LEFT JOIN domicilio d
ON d.id_repartidor = r.id_repartidor
WHERE d.id_domicilio IS NULL;    


-- VISTAS
-- Vista resumen de desempeño
CREATE VIEW vista_desempeno_repartidor AS
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


