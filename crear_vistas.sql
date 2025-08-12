-- Muestra ingresos, gastos y saldo del mes.
CREATE OR REPLACE VIEW view_monthly_balance AS
SELECT
  u.id AS user_id,
  u.name AS user_name,
  YEAR(t.transaction_date) AS year,
  MONTH(t.transaction_date) AS month,
  SUM(CASE WHEN c.type = 'income' THEN t.amount ELSE 0 END) AS total_income,
  SUM(CASE WHEN c.type = 'expense' THEN t.amount ELSE 0 END) AS total_expense,
  SUM(CASE WHEN c.type = 'income' THEN t.amount ELSE 0 END)
    - SUM(CASE WHEN c.type = 'expense' THEN t.amount ELSE 0 END) AS balance
FROM transactions t
JOIN categories c ON t.category_id = c.id
JOIN users u ON t.user_id = u.id
GROUP BY u.id, u.name, YEAR(t.transaction_date), MONTH(t.transaction_date);

-- ver en qué se gasta más.
CREATE OR REPLACE VIEW view_expenses_by_category AS
SELECT 
    u.id AS user_id,
    u.name AS user_name,
    c.id AS category_id,
    c.name AS category_name,
    YEAR(t.transaction_date) AS year,
    MONTH(t.transaction_date) AS month,
    SUM(t.amount) AS total_spent
FROM transactions t
JOIN categories c ON t.category_id = c.id
JOIN users u ON t.user_id = u.id
WHERE c.type = 'expense'
GROUP BY 
    u.id, u.name,
    c.id, c.name,
    YEAR(t.transaction_date),
    MONTH(t.transaction_date);



-- Muestra el presupuesto asignado y cuánto se ha gastado en esa categoría.
CREATE VIEW view_budget_vs_spent AS
SELECT 
    u.id AS user_id,
    u.name AS user_name,
    c.name AS category_name,
    mb.budget_month,
    mb.budget_amount,
    COALESCE(SUM(t.amount), 0) AS total_spent,
    (mb.budget_amount - COALESCE(SUM(t.amount), 0)) AS remaining
FROM monthly_budgets mb
JOIN categories c ON mb.category_id = c.id
JOIN users u ON mb.user_id = u.id
LEFT JOIN transactions t 
    ON t.user_id = mb.user_id
    AND t.category_id = mb.category_id
    AND DATE_FORMAT(t.transaction_date, '%Y-%m') = DATE_FORMAT(mb.budget_month, '%Y-%m')
GROUP BY mb.id, u.name, c.name, mb.budget_month, mb.budget_amount;

-- Para mostrar un resumen rápido tipo “dashboard”.
CREATE OR REPLACE VIEW view_latest_transactions AS
SELECT 
    t.id AS transaction_id,
    u.name AS user_name,
    c.name AS category_name,
    c.type,
    t.amount,
    t.description,
    t.transaction_date
FROM transactions t
JOIN categories c ON t.category_id = c.id
JOIN users u ON t.user_id = u.id;




