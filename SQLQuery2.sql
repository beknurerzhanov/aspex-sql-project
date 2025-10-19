/*  Обеспечил целостность данных с безопасными проверками, 
чтобы избежать ошибок при повторном запуске. Проверил на существование ограничения, наличие
первичных и внешних ключей между таблицами и добавил их, если они отсутствуют*/
IF NOT EXISTS (
    SELECT 1 FROM sys.key_constraints kc
    JOIN sys.objects o ON kc.parent_object_id = o.object_id
    WHERE o.name='DetailForBicycle' AND kc.type = 'PK'
)
BEGIN
    ALTER TABLE dbo.DetailForBicycle
    ADD CONSTRAINT PK_DetailForBicycle PRIMARY KEY (BicycleId, DetailId);
    PRINT 'Добавлен PK_DetailForBicycle';
END

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE parent_object_id = OBJECT_ID('dbo.DetailForBicycle') AND name = 'FK_DFB_Bicycle')
BEGIN
    ALTER TABLE dbo.DetailForBicycle
    ADD CONSTRAINT FK_DFB_Bicycle FOREIGN KEY (BicycleId) REFERENCES dbo.Bicycle(Id);
    PRINT 'Добавлен FK_DFB_Bicycle';
END

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE parent_object_id = OBJECT_ID('dbo.DetailForBicycle') AND name = 'FK_DFB_Detail')
BEGIN
    ALTER TABLE dbo.DetailForBicycle
    ADD CONSTRAINT FK_DFB_Detail FOREIGN KEY (DetailId) REFERENCES dbo.Detail(Id);
    PRINT 'Добавлен FK_DFB_Detail';
END

-- ServiceBook FK
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE parent_object_id = OBJECT_ID('dbo.ServiceBook') AND name = 'FK_ServiceBook_Bicycle')
BEGIN
    ALTER TABLE dbo.ServiceBook
    ADD CONSTRAINT FK_ServiceBook_Bicycle FOREIGN KEY (BicycleId) REFERENCES dbo.Bicycle(Id);
    PRINT 'Добавлен FK_ServiceBook_Bicycle';
END

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE parent_object_id = OBJECT_ID('dbo.ServiceBook') AND name = 'FK_ServiceBook_Detail')
BEGIN
    ALTER TABLE dbo.ServiceBook
    ADD CONSTRAINT FK_ServiceBook_Detail FOREIGN KEY (DetailId) REFERENCES dbo.Detail(Id);
    PRINT 'Добавлен FK_ServiceBook_Detail';
END

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE parent_object_id = OBJECT_ID('dbo.ServiceBook') AND name = 'FK_ServiceBook_Staff')
BEGIN
    ALTER TABLE dbo.ServiceBook
    ADD CONSTRAINT FK_ServiceBook_Staff FOREIGN KEY (StaffId) REFERENCES dbo.Staff(Id);
    PRINT 'Добавлен FK_ServiceBook_Staff';
END

-- RentBook FK
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE parent_object_id = OBJECT_ID('dbo.RentBook') AND name = 'FK_RentBook_Bicycle')
BEGIN
    ALTER TABLE dbo.RentBook
    ADD CONSTRAINT FK_RentBook_Bicycle FOREIGN KEY (BicycleId) REFERENCES dbo.Bicycle(Id);
    PRINT 'Добавлен FK_RentBook_Bicycle';
END

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE parent_object_id = OBJECT_ID('dbo.RentBook') AND name = 'FK_RentBook_Client')
BEGIN
    ALTER TABLE dbo.RentBook
    ADD CONSTRAINT FK_RentBook_Client FOREIGN KEY (ClientId) REFERENCES dbo.Client(Id);
    PRINT 'Добавлен FK_RentBook_Client';
END

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE parent_object_id = OBJECT_ID('dbo.RentBook') AND name = 'FK_RentBook_Staff')
BEGIN
    ALTER TABLE dbo.RentBook
    ADD CONSTRAINT FK_RentBook_Staff FOREIGN KEY (StaffId) REFERENCES dbo.Staff(Id);
    PRINT 'Äîáàâëåí FK_RentBook_Staff';
END

GO
