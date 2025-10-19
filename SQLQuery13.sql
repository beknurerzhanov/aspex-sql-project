-- 3 пример: ѕремии сотрудников за мес€ц по формуле  X = (P1*X1 + P2*X2)*X0, где P1 Ц стоимость аренды, 
-- X1 Ц процент премии от аренды, P2 Ц стоимость ремонта, X2 Ц процент премии от ремонта, X0 Ц процент премии от стажа.
DECLARE @Y INT = YEAR(GETDATE()), @M INT = MONTH(GETDATE());
;WITH RentPerStaff AS (
  SELECT r.StaffId, SUM(b.RentPrice * r.DurationHours) AS RentSum
  FROM dbo.RentBook r JOIN dbo.Bicycle b ON b.Id = r.BicycleId
  WHERE r.Paid = 1 AND YEAR(r.Date)=@Y AND MONTH(r.Date)=@M
  GROUP BY r.StaffId
), RepairPerStaff AS (
  SELECT s.StaffId, SUM(s.Price) AS RepairSum
  FROM dbo.ServiceBook s
  WHERE YEAR(s.Date)=@Y AND MONTH(s.Date)=@M
  GROUP BY s.StaffId
)
SELECT st.Id StaffId, st.Name StaffName, ISNULL(rp.RentSum,0) RentSum, ISNULL(sp.RepairSum,0) RepairSum,
       CASE WHEN DATEDIFF(day, ISNULL(st.HireDate, SYSUTCDATETIME()), SYSUTCDATETIME()) < 365 THEN 0.05
            WHEN DATEDIFF(day, ISNULL(st.HireDate, SYSUTCDATETIME()), SYSUTCDATETIME()) BETWEEN 365 AND 2*365 THEN 0.10
            ELSE 0.15 END AS TenurePercent,
       (ISNULL(rp.RentSum,0)*0.3 + ISNULL(sp.RepairSum,0)*0.8) *
       (CASE WHEN DATEDIFF(day, ISNULL(st.HireDate, SYSUTCDATETIME()), SYSUTCDATETIME()) < 365 THEN 0.05
            WHEN DATEDIFF(day, ISNULL(st.HireDate, SYSUTCDATETIME()), SYSUTCDATETIME()) BETWEEN 365 AND 2*365 THEN 0.10
            ELSE 0.15 END) AS BonusAmount
FROM dbo.Staff st
LEFT JOIN RentPerStaff rp ON rp.StaffId = st.Id
LEFT JOIN RepairPerStaff sp ON sp.StaffId = st.Id
ORDER BY BonusAmount DESC;