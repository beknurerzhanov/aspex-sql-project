-- 5 ������: ������� ��������� ������� �� ���� ������ � ���������� �������� �� ����������
SELECT d.Type, st.Name StaffName, COUNT(s.Id) RepairsCount, AVG(s.Price) AvgRepairPrice
FROM dbo.ServiceBook s JOIN dbo.Detail d ON d.Id = s.DetailId JOIN dbo.Staff st ON st.Id = s.StaffId
GROUP BY d.Type, st.Name
ORDER BY d.Type, RepairsCount DESC;