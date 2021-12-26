--all data
--select * from cars left join models on
--	cars.c_id = models.c_id
--	left join price on models.model_name = price.model_name




-- кількість машин на втоматичній і механічній коробці передач
select count(transmission) from models where transmission = 'automatic'
select count(transmission) from models where transmission = 'mechanical'

-- кількість моделей в кожного атовиробника
select c_name, count(model_name)
	from cars
	left join models on cars.c_id = models.c_id
	group by c_name

-- середня ціна моделі автовиробника
select c_name, (sum(price)/count(models.model_name))
	from cars
		join models on cars.c_id = models.c_id
		join price on models.model_name = price.model_name
group by c_name