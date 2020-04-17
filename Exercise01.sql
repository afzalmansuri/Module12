Task 3 -------------------

USE InternetSales
GO


CREATE TABLE dbo.ShoppingCart
(SessionID INT NOT NULL,
TimeAdded DATETIME NOT NULL,
CustomerKey INT NOT NULL,
ProductKey INT NOT NULL,
Quantity INT NOT NULL
PRIMARY KEY NONCLUSTERED (SessionID, ProductKey))
WITH (MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA); 




Task 4 -------------------------



USE InternetSales
GO

INSERT INTO dbo.ShoppingCart (SessionID, TimeAdded, CustomerKey, ProductKey,
Quantity)
VALUES (1, GETDATE(), 2, 3, 1);

INSERT INTO dbo.ShoppingCart (SessionID, TimeAdded, CustomerKey, ProductKey,
Quantity)
VALUES (1, GETDATE(), 2, 4, 1);


SELECT * FROM dbo.ShoppingCart; 