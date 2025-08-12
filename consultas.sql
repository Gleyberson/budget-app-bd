-- Gastos por categoría de un usuario, pero solo mostrar las que superan $100.
SELECT 
    c.name AS category_name,
    SUM(t.amount) AS total_spent
FROM transactions t
INNER JOIN categories c ON t.category_id = c.id
WHERE t.user_id = 1 AND c.type = 'expense'
GROUP BY c.name
HAVING total_spent > 100;

-- Obtener todas las transacciones con el nombre de la categoría y del usuario.
SELECT 
    u.name AS user_name,
    c.name AS category_name,
    t.amount,
    t.transaction_date
FROM transactions t
INNER JOIN categories c ON t.category_id = c.id
INNER JOIN users u ON t.user_id = u.id
ORDER BY t.transaction_date DESC;

-- Listar todas las categorías de un usuario, aunque no tengan transacciones este mes.
SELECT 
    c.name AS category_name,
    COALESCE(SUM(t.amount), 0) AS total_spent
FROM categories c
LEFT JOIN transactions t 
    ON c.id = t.category_id 
    AND t.user_id = c.user_id
    AND DATE_FORMAT(t.transaction_date, '%Y-%m') = '2025-08'
WHERE c.user_id = 1
GROUP BY c.name;

-- Mostrar las transacciones que superan el gasto promedio del usuario en agosto 2025.
SELECT 
    t.description,
    t.amount,
    t.transaction_date
FROM transactions t
WHERE t.user_id = 1
  AND DATE_FORMAT(t.transaction_date, '%Y-%m') = '2025-08'
  AND t.amount > (
      SELECT AVG(amount)
      FROM transactions
      WHERE user_id = 1
        AND DATE_FORMAT(transaction_date, '%Y-%m') = '2025-08'
  );

-- Ver el gasto total de cada categoría y su porcentaje sobre el total mensual.
SELECT 
    category_name,
    total_spent,
    CONCAT(ROUND((total_spent / total_month) * 100, 2), '%') AS percent_of_month
FROM (
    SELECT 
        c.name AS category_name,
        SUM(t.amount) AS total_spent,
        SUM(SUM(t.amount)) OVER () AS total_month
    FROM transactions t
    INNER JOIN categories c ON t.category_id = c.id
    WHERE t.user_id = 1
      AND c.type = 'expense'
      AND DATE_FORMAT(t.transaction_date, '%Y-%m') = '2025-08'
    GROUP BY c.name
) AS category_totals;


