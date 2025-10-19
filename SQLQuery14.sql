-- 4 пример: Топ 3 клиента по выручке
SELECT TOP 3 c.Id ClientId, c.Name, SUM(b.RentPrice * r.DurationHours) AS TotalSpent
FROM dbo.Client c JOIN dbo.RentBook r ON r.ClientId = c.Id JOIN dbo.Bicycle b ON b.Id = r.BicycleId
WHERE r.Paid = 1
GROUP BY c.Id, c.Name
ORDER BY TotalSpent DESC;