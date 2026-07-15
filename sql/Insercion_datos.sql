USE pizzeria_don_piccolo;

-- Datos tabla cliente
INSERT INTO cliente (nombre, telefono, direccion, correo) VALUES
('Samuel David Gelvez','3001234567','Calle 10 #20-30','samuel@gmail.com'),
('Juan Pérez','3011111111','Carrera 15 #40-20','juan@gmail.com'),
('María Gómez','3022222222','Calle 25 #10-15','maria@gmail.com'),
('Carlos Rodríguez','3033333333','Carrera 8 #15-40','carlos@gmail.com'),
('Laura Martínez','3044444444','Calle 18 #35-12','laura@gmail.com'),
('Andrés López','3055555555','Carrera 22 #45-16','andres@gmail.com'),
('Sofía Ramírez','3066666666','Calle 12 #18-30','sofia@gmail.com'),
('Diego Torres','3077777777','Carrera 30 #50-10','diego@gmail.com'),
('Valentina Castro','3088888888','Calle 50 #12-05','valentina@gmail.com'),
('Miguel Herrera','3099999999','Carrera 5 #25-60','miguel@gmail.com');

-- Datos tabla pizza
INSERT INTO pizza (nombre, tamano, tipo, precio_base) VALUES
('Hawaiana','Mediana','Clasica',32000),
('Pepperoni','Mediana','Especial',35000),
('Vegetariana','Mediana','Vegetariana',30000),
('Pollo BBQ','Grande','Especial',45000),
('Mexicana','Grande','Especial',47000),
('Napolitana','Pequena','Clasica',25000),
('Cuatro Quesos','Grande','Especial',48000),
('Jamón y Queso','Mediana','Clasica',31000),
('Carnes','Familiar','Especial',62000),
('Suprema Vegetal','Grande','Vegetariana',43000);

-- Datos tabla ingredientes
INSERT INTO ingrediente (nombre, stock, stock_minimo, costo_unitario) VALUES
('Queso Mozzarella',10000,2000,0.05),
('Jamón',5000,1000,0.08),
('Pepperoni',5000,1000,0.10),
('Piña',4000,800,0.04),
('Salsa de Tomate',8000,1500,0.03),
('Pollo',5000,1000,0.09),
('Carne Molida',5000,1000,0.11),
('Tocineta',3000,500,0.12),
('Champiñones',4000,800,0.07),
('Pimentón',3500,700,0.04),
('Cebolla',3500,700,0.03),
('Aceitunas',2000,400,0.06),
('Maíz',3000,500,0.04),
('Orégano',1000,200,0.02),
('Masa para Pizza',500,100,3.50);

-- Datos tabla repartidores
INSERT INTO repartidor (nombre, zona, estado) VALUES
('Luis Moreno','Norte','Disponible'),
('Camilo Díaz','Sur','Disponible'),
('Jorge Rojas','Centro','Disponible'),
('Kevin García','Occidente','Disponible'),
('Felipe Vargas','Oriente','Disponible');

-- Datos pizza ingrediente
INSERT INTO pizza_ingrediente (id_pizza, id_ingrediente, cantidad) VALUES
-- Hawaiana
(1,1,200),(1,2,100),(1,4,80),(1,5,120),(1,15,1),

-- Pepperoni
(2,1,220),(2,3,120),(2,5,120),(2,15,1),

-- Vegetariana
(3,1,180),(3,9,80),(3,10,60),(3,11,60),(3,5,120),(3,15,1),

-- Pollo BBQ
(4,1,220),(4,6,120),(4,5,120),(4,15,1),

-- Mexicana
(5,1,220),(5,7,120),(5,10,50),(5,11,50),(5,5,120),(5,15,1),

-- Napolitana
(6,1,180),(6,5,120),(6,14,10),(6,15,1),

-- Cuatro Quesos
(7,1,300),(7,5,120),(7,15,1),

-- Jamón y Queso
(8,1,220),(8,2,120),(8,5,120),(8,15,1),

-- Carnes
(9,1,250),(9,7,100),(9,8,80),(9,3,80),(9,5,120),(9,15,1),

-- Suprema Vegetal
(10,1,200),(10,9,70),(10,10,50),(10,11,50),(10,12,40),(10,13,50),(10,15,1);

-- datos tabla pedidos
INSERT INTO pedido (id_cliente, fecha_hora, estado) VALUES
(1,'2026-07-01 18:30:00','Entregado'),
(1,'2026-07-03 19:10:00','Entregado'),
(1,'2026-07-05 20:15:00','Entregado'),
(1,'2026-07-07 18:45:00','Entregado'),
(1,'2026-07-09 21:00:00','Cancelado'),
(1,'2026-07-11 19:20:00','Entregado'),

(3,'2026-07-02 18:40:00','Entregado'),
(3,'2026-07-04 20:00:00','Entregado'),
(3,'2026-07-06 19:30:00','Pendiente'),
(3,'2026-07-08 21:10:00','Entregado'),

(2,'2026-07-10 18:00:00','Entregado'),
(2,'2026-07-12 19:00:00','En Preparacion'),
(2,'2026-07-13 20:10:00','Entregado'),

(5,'2026-07-14 19:00:00','Entregado'),
(5,'2026-07-15 20:30:00','Entregado'),

(6,'2026-07-16 18:50:00','Entregado'),
(6,'2026-07-17 21:15:00','Pendiente'),

(7,'2026-07-18 19:45:00','Entregado'),

(8,'2026-07-19 20:20:00','Entregado'),
(9,'2026-07-20 18:35:00','Entregado');

-- Datos tabla detalle de pedidos
INSERT INTO detalle_pedido
(id_pedido,id_pizza,cantidad,precio_unitario)
VALUES

(1,1,2,32000),
(1,2,1,35000),

(2,9,1,62000),

(3,4,1,45000),
(3,1,1,32000),

(4,2,3,35000),

(5,5,1,47000),

(6,3,1,30000),
(6,1,1,32000),

(7,5,1,47000),

(8,6,2,25000),

(9,3,1,30000),

(10,10,1,43000),

(11,9,2,62000),

(12,2,1,35000),

(13,1,1,32000),

(14,7,2,48000),

(15,4,1,45000),

(16,5,1,47000),
(16,2,1,35000),

(17,3,2,30000),

(18,3,1,30000),

(19,9,1,62000),
(19,2,1,35000),

(20,1,2,32000);

-- Se insertan los datos de la tabla pago, usando la funcion calcular_total_pedido().
INSERT INTO pago (id_pedido, metodo_pago, fecha_pago, valor) VALUES
(1, 'Tarjeta',  '2026-07-01 19:15:00', calcular_total_pedido(1)),
(2, 'Efectivo', '2026-07-03 19:40:00', calcular_total_pedido(2)),
(3, 'App',      '2026-07-05 20:45:00', calcular_total_pedido(3)),
(4, 'Tarjeta',  '2026-07-07 19:30:00', calcular_total_pedido(4)),
(6, 'Efectivo', '2026-07-11 20:00:00', calcular_total_pedido(6)),
(7, 'Tarjeta',  '2026-07-02 19:20:00', calcular_total_pedido(7)),
(8, 'Efectivo', '2026-07-04 20:35:00', calcular_total_pedido(8)),
(10,'Tarjeta',  '2026-07-08 21:45:00', calcular_total_pedido(10)),
(11,'App',      '2026-07-10 18:45:00', calcular_total_pedido(11)),
(13,'Tarjeta',  '2026-07-13 20:50:00', calcular_total_pedido(13)),
(14,'Tarjeta',  '2026-07-14 19:50:00', calcular_total_pedido(14)),
(15,'Efectivo', '2026-07-15 21:00:00', calcular_total_pedido(15)),
(16,'App',      '2026-07-16 19:30:00', calcular_total_pedido(16)),
(18,'Efectivo', '2026-07-18 20:20:00', calcular_total_pedido(18)),
(19,'Tarjeta',  '2026-07-19 21:00:00', calcular_total_pedido(19)),
(20,'App',      '2026-07-20 19:15:00', calcular_total_pedido(20));

-- Se insertan solo los datos entregados como domicilios
INSERT INTO domicilio
(id_pedido, id_repartidor, hora_salida, hora_entrega, distancia, costo_envio)
VALUES

(1,1,'2026-07-01 18:50:00','2026-07-01 19:15:00',4.5,5000),

(2,2,'2026-07-03 19:15:00','2026-07-03 19:40:00',3.2,4000),

(3,4,'2026-07-05 20:20:00','2026-07-05 20:45:00',6.5,7000),

(4,1,'2026-07-07 19:00:00','2026-07-07 19:30:00',5.0,6000),

(6,5,'2026-07-11 19:35:00','2026-07-11 20:00:00',2.8,4000),

(7,3,'2026-07-02 18:55:00','2026-07-02 19:20:00',7.1,8000),

(8,4,'2026-07-04 20:10:00','2026-07-04 20:35:00',3.8,5000),

(10,1,'2026-07-08 21:20:00','2026-07-08 21:45:00',4.3,5000),

(11,5,'2026-07-10 18:20:00','2026-07-10 18:45:00',6.0,7000),

(13,2,'2026-07-13 20:25:00','2026-07-13 20:50:00',2.5,4000),

(14,4,'2026-07-14 19:25:00','2026-07-14 19:50:00',5.5,6000),

(15,3,'2026-07-15 20:35:00','2026-07-15 21:00:00',4.0,5000),

(16,1,'2026-07-16 19:05:00','2026-07-16 19:30:00',8.2,9000),

(18,5,'2026-07-18 19:55:00','2026-07-18 20:20:00',3.5,5000),

(19,2,'2026-07-19 20:35:00','2026-07-19 21:00:00',4.7,6000),

(20,3,'2026-07-20 18:50:00','2026-07-20 19:15:00',5.9,7000);

-- Datos de prueba antes de crear el trigger para historial de precios
INSERT INTO historial_precio
(id_pizza, precio_anterior, precio_nuevo, fecha_cambio)
VALUES

(1,30000,32000,'2026-06-15 10:00:00'),

(2,33000,35000,'2026-06-20 09:30:00'),

(4,42000,45000,'2026-06-25 16:10:00'),

(5,45000,47000,'2026-06-28 14:40:00'),

(9,60000,62000,'2026-06-30 11:20:00');
