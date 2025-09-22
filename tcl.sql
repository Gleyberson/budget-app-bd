-- Ejemplo 1: Uso básico de START TRANSACTION, COMMIT y ROLLBACK

-- Iniciamos la transacción
START TRANSACTION;

-- Insertamos una nueva transacción (gasto en comida)
INSERT INTO transactions (user_id, category_id, amount, description, transaction_date, created_at)
VALUES (1, 3, 5000, 'Compra supermercado', CURDATE(), NOW());

-- Revisamos que se insertó
SELECT * FROM transactions WHERE description = 'Compra supermercado';

-- Si todo está bien:
COMMIT;

-- Si queremos cancelar el cambio:
ROLLBACK;


-- Ejemplo 2: Uso de SAVEPOINT y ROLLBACK TO
START TRANSACTION;

-- Primer insert
INSERT INTO transactions (user_id, category_id, amount, description, transaction_date, created_at)
VALUES (1, 4, 2000, 'Taxi', CURDATE(), NOW());

-- Creamos un SAVEPOINT
SAVEPOINT before_coffee;

-- Segundo insert
INSERT INTO transactions (user_id, category_id, amount, description, transaction_date, created_at)
VALUES (1, 4, 1500, 'Café', CURDATE(), NOW());

-- Cancelamos SOLO la última operación
ROLLBACK TO before_coffee;

-- Confirmamos la transacción (solo se guarda el Taxi, no el Café)
COMMIT;

-- Ejemplo 3: RELEASE SAVEPOINT
START TRANSACTION;

-- Insert de prueba
INSERT INTO transactions (user_id, category_id, amount, description, transaction_date, created_at)
VALUES (1, 3, 3000, 'Cena rápida', CURDATE(), NOW());

-- Guardamos punto de control
SAVEPOINT sp_dinner;

-- Hacemos otro insert
INSERT INTO transactions (user_id, category_id, amount, description, transaction_date, created_at)
VALUES (1, 3, 8000, 'Restaurante', CURDATE(), NOW());

-- Eliminamos el savepoint porque ya no lo necesitaremos
RELEASE SAVEPOINT sp_dinner;

-- Al hacer rollback ya no podremos volver al savepoint eliminado
ROLLBACK;

-- Ejemplo 4: Sinónimos COMMIT TRANSACTION y ROLLBACK TRANSACTION
START TRANSACTION;

INSERT INTO transactions (user_id, category_id, amount, description, transaction_date, created_at)
VALUES (1, 3, 10000, 'Compra grande', CURDATE(), NOW());

-- Confirmamos
COMMIT;

-- O si queremos revertir
ROLLBACK;

