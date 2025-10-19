-- Загрузим тестовых данных
IF NOT EXISTS (SELECT 1 FROM dbo.Bicycle)
BEGIN
    INSERT INTO Bicycle (Brand, RentPrice) VALUES
    ('Giant Escape 3', 5.00),
    ('Trek FX 1', 6.50),
    ('Specialized Sirrus', 7.00),
    ('Merida Crossway', 6.00),
    ('Cube Nature', 5.50),
    ('Cannondale Quick', 8.00);
    PRINT 'Вставлены данные в Bicycle';
END

IF NOT EXISTS (SELECT 1 FROM dbo.Client)
BEGIN
    INSERT INTO Client (Name, Passport, PhoneNumber, Country) VALUES
    ('Ivan', 'AA1111111', '+77001234567', 'KZ'),
    ('Olga', 'BB2222222', '+77007654321', 'KZ'),
    ('John', 'US3333333', '+12025550123', 'US'),
    ('Anna', 'CC4444444', '+77001230000', 'KZ'),
    ('Pavel', 'DD5555555', '+77009998877', 'RU');
    PRINT 'Вставлены данные в Client';
END

IF NOT EXISTS (SELECT 1 FROM dbo.Staff)
BEGIN
    INSERT INTO Staff (Name, Passport, HireDate) VALUES
    ('Aidar', 'STF001', DATEADD(month, -6, SYSUTCDATETIME())),
    ('Marina', 'STF002', DATEADD(year, -1, DATEADD(day, -5, SYSUTCDATETIME()))),
    ('Sergey', 'STF003', DATEADD(year, -3, SYSUTCDATETIME())),
    ('Alina', 'STF004', DATEADD(year, -2, DATEADD(day, 30, SYSUTCDATETIME())));
    PRINT 'Вставлены данные в Staff';
END

IF NOT EXISTS (SELECT 1 FROM dbo.Detail)
BEGIN
    INSERT INTO Detail (Brand, Type, Name, Price) VALUES
    ('Shimano', 'Chain', 'CN-HG53', 12.00),
    ('SRAM', 'Cassette', 'PG-950', 25.00),
    ('KMC', 'Chain', 'Z8.3', 10.00),
    ('Shimano', 'BrakePads', 'BR-6100', 15.00),
    ('Generic', 'Tire', 'CityTire', 20.00);
    PRINT 'Вставлены данные в Detail';
END

IF NOT EXISTS (SELECT 1 FROM dbo.DetailForBicycle)
BEGIN
    INSERT INTO DetailForBicycle (BicycleId, DetailId) VALUES
    (1,1),(1,3),(1,5),
    (2,1),(2,2),
    (3,2),(3,4),(3,5),
    (4,5),
    (5,3),(5,4),
    (6,2),(6,1);
    PRINT 'Вставлены данные в DetailForBicycle';
END

IF NOT EXISTS (SELECT 1 FROM dbo.RentBook)
BEGIN
    INSERT INTO RentBook (Date, DurationHours, Paid, BicycleId, ClientId, StaffId) VALUES
    (DATEADD(day, -60, SYSUTCDATETIME()), 4, 1, 1, 1, 1),
    (DATEADD(day, -45, SYSUTCDATETIME()), 2, 2, 2, 2, 2),
    (DATEADD(day, -30, SYSUTCDATETIME()), 6, 3, 3, 1, 3),
    (DATEADD(day, -15, SYSUTCDATETIME()), 3, 1, 4, 1, 2),
    (DATEADD(day, -10, SYSUTCDATETIME()), 1, 6, 5, 1, 3),
    (DATEADD(day, -5, SYSUTCDATETIME()), 8, 3, 2, 1, 1),
    (DATEADD(day, -2, SYSUTCDATETIME()), 2, 4, 1, 1, 4);
    PRINT 'Вставлены данные в RentBook';
END

IF NOT EXISTS (SELECT 1 FROM dbo.ServiceBook)
BEGIN
    INSERT INTO ServiceBook (BicycleId, DetailId, Date, Price, StaffId) VALUES
    (1,1, DATEADD(day, -50, SYSUTCDATETIME()), 30.00, 1),
    (2,2, DATEADD(day, -40, SYSUTCDATETIME()), 45.00, 2),
    (3,4, DATEADD(day, -20, SYSUTCDATETIME()), 60.00, 3),
    (1,5, DATEADD(day, -12, SYSUTCDATETIME()), 25.00, 2),
    (6,2, DATEADD(day, -8, SYSUTCDATETIME()), 80.00, 3),
    (5,3, DATEADD(day, -3, SYSUTCDATETIME()), 20.00, 4);
    PRINT 'Âñòàâëåíû äàííûå â ServiceBook';
END

GO
