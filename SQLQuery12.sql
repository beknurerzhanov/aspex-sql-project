-- Второй пример: Доходы по месяцам, использовал аренду
SELECT YEAR(r.Date) AS [Year], MONTH(r.Date) AS [Month],
       SUM(CASE WHEN r.Paid = 1 THEN b.RentPrice * r.DurationHours ELSE 0 END) AS RentRevenue
FROM dbo.RentBook r JOIN dbo.Bicycle b ON b.Id = r.BicycleId
GROUP BY YEAR(r.Date), MONTH(r.Date)
ORDER BY [Year], [Month];