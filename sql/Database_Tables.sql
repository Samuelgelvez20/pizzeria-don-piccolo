-- Creacion de base de datos pizzeria_don_piccolo
CREATE DATABASE IF NOT EXISTS pizzeria_don_piccolo;

USE pizzeria_don_piccolo;

-- Tabla cliente
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    correo VARCHAR(100) UNIQUE
);

-- Tabla pizza
CREATE TABLE pizza (
    id_pizza INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tamano ENUM('Pequena','Mediana','Grande','Familiar') NOT NULL,
    tipo ENUM('Clasica','Especial','Vegetariana') NOT NULL,
    precio_base DECIMAL(10,2) NOT NULL
);

-- Tabla ingrediente
CREATE TABLE ingrediente (
    id_ingrediente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    stock DECIMAL(10,2) NOT NULL,
    stock_minimo DECIMAL(10,2) NOT NULL,
    costo_unitario DECIMAL(10,2) NOT NULL
);

-- Tabla repartidor
CREATE TABLE repartidor (
    id_repartidor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    zona VARCHAR(100) NOT NULL,
    estado ENUM('Disponible','No Disponible') NOT NULL
);

-- Tabla pedido
CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    estado ENUM(
        'Pendiente',
        'En Preparacion',
        'Entregado',
        'Cancelado'
    ) NOT NULL,

    FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
);

-- Tabla detalle pedido
CREATE TABLE detalle_pedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_pizza INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (id_pedido)
        REFERENCES pedido(id_pedido),

    FOREIGN KEY (id_pizza)
        REFERENCES pizza(id_pizza)
);

-- Tabla pizza ingredientes
CREATE TABLE pizza_ingrediente (
    id_pizza INT NOT NULL,
    id_ingrediente INT NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (id_pizza, id_ingrediente),

    FOREIGN KEY (id_pizza)
        REFERENCES pizza(id_pizza),

    FOREIGN KEY (id_ingrediente)
        REFERENCES ingrediente(id_ingrediente)
);

-- Tabla pagos
CREATE TABLE pago (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT UNIQUE NOT NULL,
    metodo_pago ENUM(
        'Efectivo',
        'Tarjeta',
        'App'
    ) NOT NULL,
    fecha_pago DATETIME NOT NULL,
    valor DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (id_pedido)
        REFERENCES pedido(id_pedido)
);

-- Tabla domicilios
CREATE TABLE domicilio (
    id_domicilio INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT UNIQUE NOT NULL,
    id_repartidor INT NOT NULL,

    hora_salida DATETIME,
    hora_entrega DATETIME,

    distancia DECIMAL(5,2),
    costo_envio DECIMAL(10,2),

    FOREIGN KEY (id_pedido)
        REFERENCES pedido(id_pedido),

    FOREIGN KEY (id_repartidor)
        REFERENCES repartidor(id_repartidor)
);

-- Tabla historial precio
CREATE TABLE historial_precio (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_pizza INT NOT NULL,

    precio_anterior DECIMAL(10,2) NOT NULL,
    precio_nuevo DECIMAL(10,2) NOT NULL,

    fecha_cambio DATETIME NOT NULL,

    FOREIGN KEY (id_pizza)
        REFERENCES pizza(id_pizza)
);

-- ver todas las tablas
SHOW TABLES;