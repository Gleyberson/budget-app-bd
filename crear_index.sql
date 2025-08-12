-- Índices en users (ya tiene PK y email UNIQUE)
CREATE INDEX idx_users_name ON users(name);

-- Índices en categories
CREATE INDEX idx_categories_user_id ON categories(user_id);
CREATE INDEX idx_categories_user_type ON categories(user_id, type);

-- Índices en transactions
CREATE INDEX idx_transactions_user_date ON transactions(user_id, transaction_date);
CREATE INDEX idx_transactions_category_date ON transactions(category_id, transaction_date);

-- Índices en monthly_budgets
CREATE INDEX idx_budgets_user_month ON monthly_budgets(user_id, budget_month);
CREATE INDEX idx_budgets_category_month ON monthly_budgets(category_id, budget_month);