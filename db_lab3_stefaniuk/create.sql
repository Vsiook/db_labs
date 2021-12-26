DROP table if exists cars CASCADE;
DROP table if exists models CASCADE;
DROP table if exists price CASCADE;

create table cars (
  c_id int primary key not null ,
  c_name char(64) not null
);

create table models(
  c_id int not null,
  model_name char(64) primary key not null,
  transmission char(64) not null
);

create table price(
	model_name char(64) not null,
	price int not null
);

alter table  models add constraint FK_cars_models foreign key (c_id) references cars (c_id);
alter table  price add constraint FK_models_price foreign key (model_name) references models (model_name);