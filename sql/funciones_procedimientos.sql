-- Funciones y procedimientos

-- 1. Función para calcular el total de un pedido (sumando precios de pizzas + costo de envío + IVA).
DROP FUNCTION IF EXISTS calcular_total_pedido;

DELIMITER $$
CREATE FUNCTION calcular_total_pedido(p_id_pedido INT)
RETURNS DECIMAL(10,2)
NOT DETERMINISTIC
READS SQL DATA
BEGIN

	DECLARE v_subtotal DECIMAL(10,2);
	DECLARE v_envio DECIMAL(10,2);
	DECLARE v_iva DECIMAL(10,2);
	DECLARE v_total DECIMAL(10,2);
    DECLARE v_porcentaje_iva DECIMAL(5,4);
    
    SET v_porcentaje_iva = 0.1900;
    
    SELECT IFNULL(SUM(cantidad * precio_unitario), 0)
	INTO v_subtotal
	FROM detalle_pedido
	WHERE id_pedido = p_id_pedido;
	
    SELECT IFNULL(MAX(costo_envio),0)
	INTO v_envio	
	FROM domicilio
	WHERE id_pedido = p_id_pedido;
    
    SET v_iva = (v_subtotal + v_envio) * v_porcentaje_iva;
    SET v_total = v_subtotal + v_envio + v_iva;
    
	RETURN v_total;

END$$
DELIMITER ;

-- 2. Función para calcular la ganancia neta diaria (ventas - costos de ingredientes).
DROP FUNCTION IF EXISTS calcular_ganancia_neta_diaria;

DELIMITER $$

CREATE FUNCTION calcular_ganancia_neta_diaria(p_fecha DATE)
RETURNS DECIMAL(10,2)
NOT DETERMINISTIC
READS SQL DATA

BEGIN

    DECLARE v_ventas DECIMAL(10,2) DEFAULT 0;
    DECLARE v_costos DECIMAL(10,2) DEFAULT 0;
    DECLARE v_ganancia DECIMAL(10,2) DEFAULT 0;

    -- Total vendido en la fecha
    SELECT IFNULL(SUM(valor),0)
    INTO v_ventas
    FROM pago
    WHERE DATE(fecha_pago) = p_fecha;

    -- Costo de ingredientes utilizados
    SELECT IFNULL(SUM(
        dp.cantidad *
        pi.cantidad *
        i.costo_unitario
    ),0)
    INTO v_costos
    FROM pedido p
    INNER JOIN detalle_pedido dp
        ON p.id_pedido = dp.id_pedido
    INNER JOIN pizza_ingrediente pi
        ON dp.id_pizza = pi.id_pizza
    INNER JOIN ingrediente i
        ON pi.id_ingrediente = i.id_ingrediente
    WHERE DATE(p.fecha_hora) = p_fecha
    AND p.estado = 'Entregado';

    SET v_ganancia = v_ventas - v_costos;

    RETURN v_ganancia;

END $$

DELIMITER ;

SELECT calcular_ganancia_neta_diaria('2026-07-10');
-- 3. Procedimiento para cambiar automáticamente el estado del pedido a “entregado” cuando se registre la hora de entrega.
DROP PROCEDURE IF EXISTS registrar_entrega;

DELIMITER $$

CREATE PROCEDURE registrar_entrega(
    IN p_id_pedido INT,
    IN p_hora_entrega DATETIME
)
BEGIN

    -- Verificar que el pedido exista
    IF NOT EXISTS (
        SELECT 1
        FROM pedido
        WHERE id_pedido = p_id_pedido
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El pedido no existe.';
    END IF;

    -- Registrar la hora de entrega
    UPDATE domicilio
    SET hora_entrega = p_hora_entrega
    WHERE id_pedido = p_id_pedido;

    -- Cambiar el estado del pedido
    UPDATE pedido
    SET estado = 'Entregado'
    WHERE id_pedido = p_id_pedido;

END $$

DELIMITER ;