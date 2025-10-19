-- Безопасное переименование колонок
/* Нужен, чтобы переименовать неудобные или некорректно названные колонки, а также с пробелами или непонятными именами в таблицах.
Так таблицы становятся удобнее для работы и запросы чище и понятнее, 
а скрипты безопаснее, так как перед переименованием проверяется, существует ли у нас колонка. */
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='Client' AND COLUMN_NAME='Phone number')
BEGIN
    EXEC sp_rename 'dbo.Client.[Phone number]', 'PhoneNumber', 'COLUMN';
    PRINT 'Переименован Client.[Phone number] -> PhoneNumber';
END

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='Staff' AND COLUMN_NAME='Date')
BEGIN
    EXEC sp_rename 'dbo.Staff.[Date]', 'HireDate', 'COLUMN';
    PRINT 'Переименован Staff.[Date] -> HireDate';
END

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='RentBook' AND COLUMN_NAME='Time')
BEGIN
    EXEC sp_rename 'dbo.RentBook.[Time]', 'DurationHours', 'COLUMN';
    PRINT 'Переименован RentBook.[Time] -> DurationHours';
END
GO



