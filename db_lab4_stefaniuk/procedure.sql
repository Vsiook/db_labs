CREATE OR REPLACE PROCEDURE filter_models_by_company(company_name varchar(64))
LANGUAGE 'plpgsql'
AS $$
BEGIN
	DROP TABLE IF EXISTS filtered_models;
	CREATE TABLE filtered_models
	AS
	(
        select cars.c_id, cars.c_name, models.model_name from cars
	        join models on cars.c_id = models.c_id
	    where  c_name = company_name
	);
END;
$$;

CALL filter_models_by_company('Kia');

select * from filtered_models