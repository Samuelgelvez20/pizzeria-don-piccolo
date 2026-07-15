-- Triggers
-- 1. Trigger de actualización automática de stock de ingredientes cuando se realiza un pedido.
DROP TRIGGER IF EXISTS actualizar_stock_ingredientes;
DELIMITER $$

CREATE TRIGGER actualizar_stock_ingredientes

AFTER INSERT
ON detalle_pedido

FOR EACH ROW

BEGIN

    UPDATE ingrediente i

    INNER JOIN pizza_ingrediente pi
        ON i.id_ingrediente = pi.id_ingrediente

    SET i.stock = i.stock - (pi.cantidad * NEW.cantidad)

    WHERE pi.id_pizza = NEW.id_pizza;

END $$

DELIMITER ;


-- 2. Trigger de auditoría que registre en una tabla historial_precios cada vez que se modifique el precio de una pizza.
DROP TRIGGER IF EXISTS auditoria_precio_pizza;

DELIMITER $$

CREATE TRIGGER auditoria_precio_pizza

AFTER UPDATE
ON pizza

FOR EACH ROW

BEGIN

    IF OLD.precio_base <> NEW.precio_base THEN

        INSERT INTO historial_precio(
            id_pizza,
            precio_anterior,
            precio_nuevo
        )

        VALUES(
            OLD.id_pizza,
            OLD.precio_base,
            NEW.precio_base
        );

    END IF;

END $$

DELIMITER ;


-- 3. Trigger para marcar repartidor como “disponible” nuevamente cuando termina un domicilio.
DROP TRIGGER IF EXISTS liberar_repartidor;

DELIMITER $$

CREATE TRIGGER liberar_repartidor

AFTER UPDATE
ON domicilio

FOR EACH ROW

BEGIN

    IF OLD.hora_entrega IS NULL
    AND NEW.hora_entrega IS NOT NULL THEN

        UPDATE repartidor
        SET estado = 'Disponible'
        WHERE id_repartidor = NEW.id_repartidor;

    END IF;

END $$

DELIMITER ;
