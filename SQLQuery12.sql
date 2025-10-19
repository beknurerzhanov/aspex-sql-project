-- Второй пример: Доходы по месяцам по аренде и по ремонту, параметризованный по периоду
DECLARE @FromDate DATE = DATEADD(MONTH, -12, CAST(GETDATE() AS date));
DECLARE @ToDate   DATE = CAST(GETDATE() AS date);

WITH RentAgg AS (
  SELECT YEAR(r.Date) AS Yr, MONTH(r.Date) AS Mo,
         SUM(CASE WHEN r.Paid = 1 THEN b.RentPrice * r.DurationHours ELSE 0 END) AS RentRevenue
  FROM dbo.RentBook r
  JOIN dbo.Bicycle b ON b.Id = r.BicycleId
  WHERE r.Date >= @FromDate AND r.Date < DATEADD(DAY,1,@ToDate)
  GROUP BY YEAR(r.Date), MONTH(r.Date)
),
RepairAgg AS (
  SELECT YEAR(s.Date) AS Yr, MONTH(s.Date) AS Mo,
         SUM(s.Price) AS RepairRevenue
  FROM dbo.ServiceBook s
  WHERE s.Date >= @FromDate AND s.Date < DATEADD(DAY,1,@ToDate)
  GROUP BY YEAR(s.Date), MONTH(s.Date)
)
SELECT COALESCE(r.Yr, s.Yr) AS [Year],
       COALESCE(r.Mo, s.Mo) AS [Month],
       ISNULL(r.RentRevenue,0)   AS RentRevenue,
       ISNULL(s.RepairRevenue,0) AS RepairRevenue,
       ISNULL(r.RentRevenue,0) + ISNULL(s.RepairRevenue,0) AS TotalRevenue
FROM RentAgg r
FULL OUTER JOIN RepairAgg s ON r.Yr = s.Yr AND r.Mo = s.Mo
ORDER BY [Year], [Month];

