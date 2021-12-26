CREATE OR REPLACE FUNCTION findMorePriceModelByCompany(company_name varchar(64)) RETURNS int AS
$$
    DECLARE
        price integer;
    BEGIN
    	select MAX(price.price) into price
			from cars
    			left join models on cars.c_id = models.c_id
	    		left join price on models.model_name = price.model_name
	        		where c_name = company_name;
	    RETURN price;
    END;
$$ LANGUAGE 'plpgsql';

SELECT findMorePriceModelByCompany('Kia');





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

select * from filtered_models;





CREATE OR REPLACE FUNCTION replace_ID()
RETURNS trigger AS
$$
	BEGIN
	    IF NEW.c_id = '0' THEN
            NEW.c_id = (select max(c_id) from cars) + 1;
        END IF;
	        RETURN NEW;
	    END;
$$ LANGUAGE 'plpgsql';
DROP TRIGGER IF EXISTS rID on cars;

CREATE TRIGGER rID
BEFORE UPDATE OR INSERT ON cars
FOR EACH ROW
EXECUTE FUNCTION replace_ID();

SELECT * FROM cars;

insert into cars(c_id,c_name)
values ('0','test1'),
	   ('0','test2');

SELECT * FROM cars;