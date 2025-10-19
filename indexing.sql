-- Создаем индексы для того, чтобы ускорить чтение данных
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_RentBook_Date' AND object_id = OBJECT_ID('dbo.RentBook'))
    CREATE INDEX IX_RentBook_Date ON dbo.RentBook([Date]);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_RentBook_BicycleId' AND object_id = OBJECT_ID('dbo.RentBook'))
    CREATE INDEX IX_RentBook_BicycleId ON dbo.RentBook(BicycleId);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_ServiceBook_Date' AND object_id = OBJECT_ID('dbo.ServiceBook'))
    CREATE INDEX IX_ServiceBook_Date ON dbo.ServiceBook([Date]);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='IX_ServiceBook_StaffId' AND object_id = OBJECT_ID('dbo.ServiceBook'))
    CREATE INDEX IX_ServiceBook_StaffId ON dbo.ServiceBook(StaffId);

GO

