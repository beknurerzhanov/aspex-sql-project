-- Первый пример Топ-5 рентабельных велосипедов
-- считаем суммарную выручку по оплаченной аренде, 
-- суммарные траты на ремонт и выводит топ-5 велосипедов по прибыли.
WITH RentRevenue AS (
  SELECT r.BicycleId, SUM(b.RentPrice * r.DurationHours) AS TotalRent
  FROM dbo.RentBook r JOIN dbo.Bicycle b ON b.Id = r.BicycleId
  WHERE r.Paid = 1
  GROUP BY r.BicycleId
), RepairCost AS (
  SELECT s.BicycleId, SUM(s.Price) AS TotalRepair
  FROM dbo.ServiceBook s
  GROUP BY s.BicycleId
)
SELECT TOP 5 b.Id, b.Brand, ISNULL(rr.TotalRent,0) TotalRent, ISNULL(rc.TotalRepair,0) TotalRepair,
       ISNULL(rr.TotalRent,0) - ISNULL(rc.TotalRepair,0) AS Profit
FROM dbo.Bicycle b
LEFT JOIN RentRevenue rr ON rr.BicycleId = b.Id
LEFT JOIN RepairCost rc ON rc.BicycleId = b.Id

ORDER BY Profit DESC;
