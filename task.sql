-- Використовуємо базу даних ShopDB
USE ShopDB;

-- Спочатку створимо клієнта з ID = 1, щоб уникнути помилки зовнішнього ключа
INSERT INTO Customers (ID, FirstName, LastName, Email, Address)
VALUES (1, 'Test', 'User', 'test@example.com', '123 Test Street');

-- Створимо продукт з ID = 1 (AwersomeProduct), щоб з ним працювати
INSERT INTO Products (ID, Name, Description, Price, WarehouseAmount)
VALUES (1, 'AwersomeProduct', 'This is an awesome product.', 99.99, 100);

-- Створюємо індекс на Customers.Email (назва індексу — Email)
CREATE INDEX Email ON Customers (Email);

-- Створюємо індекс на Products.Name (назва індексу — Name)
CREATE INDEX Name ON Products (Name);

-- Починаємо транзакцію
START TRANSACTION;

-- Створюємо замовлення від клієнта з ID = 1, дата 2023-01-01
INSERT INTO Orders (CustomerID, Date)
VALUES (1, '2023-01-01');

-- Зберігаємо ID щойно створеного замовлення
SET @order_id = LAST_INSERT_ID();

-- Додаємо товар до замовлення: продукт з ID = 1, кількість = 1
INSERT INTO OrderItems (OrderID, ProductID, Count)
VALUES (@order_id, 1, 1);

-- Зменшуємо кількість товару на складі на 1
UPDATE Products
SET WarehouseAmount = WarehouseAmount - 1
WHERE ID = 1;

-- Завершуємо транзакцію
COMMIT;
