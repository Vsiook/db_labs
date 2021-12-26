-- кількість моделей в кожного атовиробника
CREATE VIEW COUNT_MODEL AS
select c_name, count(model_name)
	from cars
	left join models on cars.c_id = models.c_id
	group by c_name

-- середня ціна моделі автовиробника
CREATE VIEW AVERAGE_PRICE_COMPANY_MODELS  AS
select c_name, (sum(price)/count(models.model_name))
	from cars
		join models on cars.c_id = models.c_id
		join price on models.model_name = price.model_name
group by c_name