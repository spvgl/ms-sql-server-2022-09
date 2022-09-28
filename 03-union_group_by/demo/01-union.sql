USE WideWorldImporters

-- --------------
-- UNION
-- --------------
-- Какие записи изменял последним сотрудник с ID=1
-- (Customers для CustomerCategoryID = 7, и Suppliers)

SELECT CustomerID as ID, CustomerName as [Name], 'customers', 0 as sort
FROM Sales.Customers
WHERE LastEditedBy = 1
AND CustomerCategoryID = 7

UNION

SELECT SupplierID as ID2, SupplierName as [Name2], 'suppliers', 1
FROM Purchasing.Suppliers
WHERE LastEditedBy = 1

UNION

SELECT -10, N'пример', 'other', -1

ORDER BY Sort


-- см. слайды





-- Задачка - вывести в одном столбце
select 'a' as Col1
union
select 'b' as Col2
union
select 'c' as Col3
go


select * 
from (values('a', 2), ('b', 4), ('c', 1)) as tbl (col1, col2)
go

-- Будет ли разница в производительности между этими вариантами?




-- Что быстрее UNION или UNION ALL?
select 'a'
union all
select 'a'

select 'a'
union
select 'a'
go

-- Совместимость по типам 
-- ошибка
select 'a'
union 
select 123
go

select 'a'
union 
select cast(123 as nchar(3))
go

-- --------------
-- INTERSECT
-- --------------

-- Что делает запрос?

SELECT LastEditedBy
FROM Sales.Customers

INTERSECT

SELECT LastEditedBy
FROM Sales.Orders

-- --------------
-- EXCEPT
-- --------------

-- Найти поставщиков (Suppliers), у которых не было сделано ни одного заказа (PurchaseOrders).
-- (в ДЗ так делать не надо, там надо только через JOIN)

-- решение: (все поставщики) минус (поставщики с заказами)

-- все поставщики
SELECT SupplierID, SupplierName 
FROM Purchasing.Suppliers

EXCEPT

-- поставщики с заказами
SELECT 
	s.SupplierID, 
	s.SupplierName
FROM Purchasing.PurchaseOrders o
JOIN Purchasing.Suppliers s ON o.SupplierID = s.SupplierID