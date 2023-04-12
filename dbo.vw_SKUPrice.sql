-- 4 Создать представление (на выходе: файл в репозитории dbo.vw_SKUPrice в ветке VIEWs)
	-- 4.1 Возвращает все атрибуты продуктов из таблицы dbo.SKU и расчетный атрибут со стоимостью одного продукта (используя функцию dbo.udf_GetSKUPrice)
if object_id('dbo.vw_SKUPrice', 'v') is not null 
	drop view dbo.vw_SKUPrice;
go

create view dbo.vw_SKUPrice
as
    select *, dbo.udf_GetSKUPrice(ID) as PricePerUnit
    from dbo.SKU;
go