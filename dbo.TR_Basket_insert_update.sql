-- 6 Создать триггер (на выходе: файл в репозитории dbo.TR_Basket_insert_update в ветке Triggers)
	-- 6.1 Если в таблицу dbo.Basket за раз добавляются 2 и более записей одного ID_SKU, то значение в поле DiscountValue, для этого ID_SKU рассчитывается по формуле Value * 5%, иначе DiscountValue = 0
create trigger dbo.TR_Basket_insert_update on dbo.Basket
after insert
as
begin
    update dbo.Basket
    set DiscountValue = case
        when (select count(*)
		from inserted
		where ID_SKU = dbo.Basket.ID_SKU) >= 2
            then Value * 0.05 else 0
		end
    where exists
    (
		select *
		from inserted as i
		where i.ID_SKU = dbo.Basket.ID_SKU
	)
end;