-- ���� ��� ����������, ��� ����� ������� ���������� ����������� �� ��������
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='UQ_Client_Passport' AND object_id = OBJECT_ID('dbo.Client'))
BEGIN
    IF NOT EXISTS (SELECT Passport FROM dbo.Client GROUP BY Passport HAVING COUNT(*) > 1)
        ALTER TABLE dbo.Client ADD CONSTRAINT UQ_Client_Passport UNIQUE (Passport);
    ELSE
        PRINT '�� �������� UQ_Client_Passport � ������� ���������';
END

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name='UQ_Staff_Passport' AND object_id = OBJECT_ID('dbo.Staff'))
BEGIN
    IF NOT EXISTS (SELECT Passport FROM dbo.Staff GROUP BY Passport HAVING COUNT(*) > 1)
        ALTER TABLE dbo.Staff ADD CONSTRAINT UQ_Staff_Passport UNIQUE (Passport);
    ELSE
        PRINT '�� �������� UQ_Staff_Passport � ������� ���������';
END
GO