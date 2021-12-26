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