-- Insertar usuarios
INSERT INTO users (name, email, password_hash) VALUES
('Juan Pérez', 'juan@example.com', 'hash_password_1'),
('María López', 'maria@example.com', 'hash_password_2');

-- Insertar categorías
INSERT INTO categories (user_id, name, type) VALUES
(1, 'Sueldo', 'income'),
(1, 'Trabajo extra', 'income'),
(1, 'Alquiler', 'expense'),
(1, 'Comida', 'expense'),
(2, 'Sueldo', 'income'),
(2, 'Servicios', 'expense');

-- Insertar transacciones
INSERT INTO transactions (user_id, category_id, amount, description, transaction_date) VALUES
(1, 1, 1500.00, 'Pago mensual empresa', '2025-08-01'),
(1, 2, 200.00, 'Proyecto freelance', '2025-08-05'),
(1, 3, 500.00, 'Renta departamento', '2025-08-02'),
(1, 4, 150.00, 'Supermercado', '2025-08-03'),
(2, 5, 1800.00, 'Sueldo oficina', '2025-08-01'),
(2, 6, 100.00, 'Cuenta de luz', '2025-08-04');

-- Insertar presupuestos mensuales
INSERT INTO monthly_budgets (user_id, category_id, budget_month, budget_amount) VALUES
(1, 3, '2025-08-01', 500.00),   -- Alquiler
(1, 4, '2025-08-01', 200.00),   -- Comida
(2, 6, '2025-08-01', 150.00);   -- Servicios
