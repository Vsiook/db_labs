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