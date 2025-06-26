-- Вмикаємо використання бази даних ShopDB
USE ShopDB;

-- Починаємо транзакцію
START TRANSACTION;

-- 1. Створюємо нове замовлення від клієнта з ID 1, дата — 2023-01-01
INSERT INTO Orders (CustomerID, Date)
VALUES (1, '2023-01-01');

-- Зберігаємо ID нового замовлення
SET @order_id = LAST_INSERT_ID();

-- 2. Додаємо товар до замовлення: продукт з ID 1, кількість — 1
INSERT INTO OrderItems (OrderID, ProductID, Count)
VALUES (@order_id, 1, 1);

-- 3. Зменшуємо кількість товару на складі (WarehouseAmount) на 1
UPDATE Products
SET WarehouseAmount = WarehouseAmount - 1
WHERE ID = 1;

-- Завершуємо транзакцію, зберігаючи всі зміни
COMMIT;
