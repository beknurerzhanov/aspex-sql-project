-- Создаем витрины BonusMart
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='BonusMart' AND TABLE_SCHEMA='dbo')
BEGIN
CREATE TABLE dbo.BonusMart
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    [Year] INT NOT NULL,
    [Month] INT NOT NULL,
    StaffId INT NOT NULL,
    StaffName VARCHAR(100) NOT NULL,
    RentSum MONEY NOT NULL DEFAULT 0,
    RepairSum MONEY NOT NULL DEFAULT 0,
    TenurePercent DECIMAL(4,2) NOT NULL,
    BonusAmount MONEY NOT NULL,
    LoadDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    CONSTRAINT UQ_BonusMart_Staff_Year_Month UNIQUE (StaffId, [Year], [Month])
);
PRINT 'Создана витрина BonusMart';
END

GO
