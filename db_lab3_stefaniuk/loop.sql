drop table if exists carscopy; 
create table carscopy as select * from cars;
delete from carscopy;
select * from carscopy;

DO $$
DECLARE
    carsName carscopy.c_name%TYPE;


BEGIN
    carsName := '()()()() - audi';
    FOR i IN 1..10
        LOOP
            INSERT INTO carscopy(c_id, c_name)
            VALUES (i,CONCAT(i , carsName));
        END LOOP;
END;
$$;

Select * from carscopy;