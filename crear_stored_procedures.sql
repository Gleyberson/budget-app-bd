-- SP 1: Insertar una nueva transacción
DELIMITER //
CREATE PROCEDURE add_transaction(
    IN p_user_id INT,
    IN p_category_id INT,
    IN p_amount DECIMAL(10,2),
    IN p_description VARCHAR(255),
    IN p_date DATE
)
BEGIN
    INSERT INTO transactions (user_id, category_id, amount, description, transaction_date, created_at)
    VALUES (p_user_id, p_category_id, p_amount, p_description, p_date, NOW());
END;
//
DELIMITER ;

-- SP 2: Generar reporte de gastos por categoría en un mes
DELIMITER //
CREATE PROCEDURE report_expenses_by_category(
    IN p_user_id INT,
    IN p_month DATE
)
BEGIN
    SELECT c.name AS category_name,
           SUM(t.amount) AS total_spent
    FROM transactions t
    JOIN categories c ON t.category_id = c.id
    WHERE t.user_id = p_user_id
      AND c.type = 'expense'
      AND DATE_FORMAT(t.transaction_date, '%Y-%m') = DATE_FORMAT(p_month, '%Y-%m')
    GROUP BY c.name
    ORDER BY total_spent DESC;
END;
//
DELIMITER ;
