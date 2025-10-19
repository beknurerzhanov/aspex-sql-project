EXEC dbo.usp_LoadBonusMart;
SELECT TOP 5 * FROM dbo.BonusMart ORDER BY [Year] DESC, [Month] DESC, BonusAmount DESC;
GO