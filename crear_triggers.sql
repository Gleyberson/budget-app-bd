DELIMITER //
CREATE TRIGGER trg_transactions_insert
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
    INSERT INTO transactions_log(transaction_id, user_id, action_type, old_amount, new_amount)
    VALUES (NEW.id, NEW.user_id, 'INSERT', NULL, NEW.amount);
END;
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER trg_transactions_update
AFTER UPDATE ON transactions
FOR EACH ROW
BEGIN
    INSERT INTO transactions_log(transaction_id, user_id, action_type, old_amount, new_amount)
    VALUES (NEW.id, NEW.user_id, 'UPDATE', OLD.amount, NEW.amount);
END;
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER trg_transactions_update
AFTER UPDATE ON transactions
FOR EACH ROW
BEGIN
    INSERT INTO transactions_log(transaction_id, user_id, action_type, old_amount, new_amount)
    VALUES (NEW.id, NEW.user_id, 'UPDATE', OLD.amount, NEW.amount);
END;
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER trg_transactions_delete
AFTER DELETE ON transactions
FOR EACH ROW
BEGIN
    INSERT INTO transactions_log(transaction_id, user_id, action_type, old_amount, new_amount)
    VALUES (OLD.id, OLD.user_id, 'DELETE', OLD.amount, NULL);
END;
//
DELIMITER ;
