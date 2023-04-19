-- 3 Создать функцию (на выходе: файл в репозитории dbo.udf_GetSKUPrice.sql в ветке Functions)
	-- 3.1 Входной параметр @ID_SKU
	-- 3.2 Рассчитывает стоимость передаваемого продукта из таблицы dbo.Basket по формуле
		-- 3.2.1 сумма Value по переданному SKU / сумма Quantity по переданному SKU
	-- 3.3 На выходе значение типа decimal(18, 2)
if object_id('dbo.udf_GetSKUPrice') is not null 
	drop function dbo.udf_GetSKUPrice;
go
create function dbo.udf_GetSKUPrice
(
	@ID_SKU as int
)
returns decimal(18, 2)
as
	begin
		return (
			select sum(Value) / nullif(sum(Quantity), 0)
			from dbo.Basket
			where ID_SKU = @ID_SKU
		)
	end;
go