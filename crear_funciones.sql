-- Función 1: Calcular el balance neto de un usuario en un mes dado
DELIMITER //
CREATE FUNCTION get_monthly_balance(p_user_id INT, p_month DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_income DECIMAL(10,2);
    DECLARE v_expense DECIMAL(10,2);

    SELECT IFNULL(SUM(t.amount),0)
    INTO v_income
    FROM transactions t
    JOIN categories c ON t.category_id = c.id
    WHERE t.user_id = p_user_id
      AND c.type = 'income'
      AND DATE_FORMAT(t.transaction_date, '%Y-%m') = DATE_FORMAT(p_month, '%Y-%m');

    SELECT IFNULL(SUM(t.amount),0)
    INTO v_expense
    FROM transactions t
    JOIN categories c ON t.category_id = c.id
    WHERE t.user_id = p_user_id
      AND c.type = 'expense'
      AND DATE_FORMAT(t.transaction_date, '%Y-%m') = DATE_FORMAT(p_month, '%Y-%m');

    RETURN v_income - v_expense;
END;
//
DELIMITER ;

-- Función 2: Retorna el presupuesto mensual de un usuario para una categoría específica
DELIMITER //
CREATE FUNCTION get_budget_for_category(p_user_id INT, p_category_id INT, p_month DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_budget DECIMAL(10,2);

    SELECT IFNULL(budget_amount,0)
    INTO v_budget
    FROM monthly_budgets
    WHERE user_id = p_user_id
      AND category_id = p_category_id
      AND DATE_FORMAT(budget_month, '%Y-%m') = DATE_FORMAT(p_month, '%Y-%m');

    RETURN v_budget;
END;
//
DELIMITER ;
