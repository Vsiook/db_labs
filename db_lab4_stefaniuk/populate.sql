insert into cars(c_id,c_name)
values (1,'subaru'),
    (2,'LADA'),
    (3,'Dodge'),
    (4,'УАЗ'),
    (5,'Kia'),
    (6,'Opel'),
    (7,'Alfa Romeo'),
    (8,'Acura');

insert into models(c_id,model_name,transmission)
values(1,'Outback','automatic'),
    (1,'Forester','automatic'),
    (2,'Vesta','automatic'),
    (2,'Largus','mechanical'),
    (3,'Dart','automatic'),
    (3,'Neon','automatic'),
    (5,'Sportage','automatic'),
    (5,'Rio','mechanical');

insert into price(model_name,price)
values('Rio',100),
    ('Sportage',200),
    ('Neon',300),
    ('Vesta',400),
    ('Forester',500),
    ('Outback',600),
    ('Largus',700);
