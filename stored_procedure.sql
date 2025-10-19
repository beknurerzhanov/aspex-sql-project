-- Создание, также замена хранимой процедуры загрузки витрины
/* Процедура автоматически рассчитывает и заносит в таблицу BonusMart ежемесячные премии 
сотрудников. Она собирает данные об арендах и ремонтах велосипедов, определяет стаж 
каждого сотрудника и рассчитывает премию по заданной формуле. При повторном запуске 
процедура обновляет уже существующие записи, не создавая дубликатов. 
Также предусматриваем обработка ошибок, чтобы загрузка данных проходила без сбоев 
или ошибок. Эта процедура используется для формирования витрины данных, 
к которой можно подключить дашборд и анализировать размер премий по месяцам. */
CREATE OR ALTER PROCEDURE dbo.usp_LoadBonusMart
    @Year INT = NULL,
    @Month INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @Year IS NULL SET @Year = YEAR(SYSUTCDATETIME());
        IF @Month IS NULL SET @Month = MONTH(SYSUTCDATETIME());

        ;WITH RentPerStaff AS (
            SELECT r.StaffId, SUM(b.RentPrice * r.DurationHours) AS RentSum
            FROM dbo.RentBook r
            JOIN dbo.Bicycle b ON b.Id = r.BicycleId
            WHERE r.Paid = 1 AND YEAR(r.Date) = @Year AND MONTH(r.Date) = @Month
            GROUP BY r.StaffId
        ),
        RepairPerStaff AS (
            SELECT s.StaffId, SUM(s.Price) AS RepairSum
            FROM dbo.ServiceBook s
            WHERE YEAR(s.Date) = @Year AND MONTH(s.Date) = @Month
            GROUP BY s.StaffId
        ),
        StaffBase AS (
            SELECT st.Id AS StaffId, st.Name, st.HireDate
            FROM dbo.Staff st
        ),
        Aggregated AS (
            SELECT sb.StaffId, sb.Name AS StaffName,
                   ISNULL(rp.RentSum,0) AS RentSum,
                   ISNULL(sp.RepairSum,0) AS RepairSum,
                   CASE
                     WHEN DATEDIFF(day, ISNULL(sb.HireDate, SYSUTCDATETIME()), SYSUTCDATETIME()) < 365 THEN 0.05
                     WHEN DATEDIFF(day, ISNULL(sb.HireDate, SYSUTCDATETIME()), SYSUTCDATETIME()) BETWEEN 365 AND 2*365 THEN 0.10
                     ELSE 0.15 END AS TenurePercent
            FROM StaffBase sb
            LEFT JOIN RentPerStaff rp ON rp.StaffId = sb.StaffId
            LEFT JOIN RepairPerStaff sp ON sp.StaffId = sb.StaffId
        )
        MERGE dbo.BonusMart AS target
        USING (
            SELECT @Year AS [Year], @Month AS [Month],
                   a.StaffId, a.StaffName, a.RentSum, a.RepairSum, a.TenurePercent,
                   (a.RentSum * 0.30 + a.RepairSum * 0.80) * a.TenurePercent AS BonusAmount
            FROM Aggregated a
        ) AS src ([Year],[Month],StaffId,StaffName,RentSum,RepairSum,TenurePercent,BonusAmount)
        ON target.StaffId = src.StaffId AND target.[Year] = src.[Year] AND target.[Month] = src.[Month]
        WHEN MATCHED THEN
            UPDATE SET StaffName = src.StaffName, RentSum = src.RentSum, RepairSum = src.RepairSum,
                       TenurePercent = src.TenurePercent, BonusAmount = src.BonusAmount, LoadDate = SYSUTCDATETIME()
        WHEN NOT MATCHED THEN
            INSERT ([Year],[Month],StaffId,StaffName,RentSum,RepairSum,TenurePercent,BonusAmount,LoadDate)
            VALUES (src.[Year],src.[Month],src.StaffId,src.StaffName,src.RentSum,src.RepairSum,src.TenurePercent,src.BonusAmount,SYSUTCDATETIME());
    END TRY
    BEGIN CATCH
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrNum INT = ERROR_NUMBER();
        RAISERROR('Ошибка в usp_LoadBonusMart: %s', 16, 1, @ErrMsg);
    END CATCH
END
GO
