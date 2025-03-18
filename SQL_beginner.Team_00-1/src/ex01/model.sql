CREATE TABLE cities
(id bigint primary key,
 name varchar not null
);

insert into cities values (1, 'a');
insert into cities values (2, 'b');
insert into cities values (3, 'c');
insert into cities values (4, 'd');

CREATE TABLE cities_cost
(id bigint primary key,
 point1 varchar not null,
 point2 varchar not null,
 cost int not null default 0
);

insert into cities_cost values (1, 'a', 'b', 10);
insert into cities_cost values (2, 'a', 'c', 15);
insert into cities_cost values (3, 'a', 'd', 20);

insert into cities_cost values (4, 'b', 'a', 10);
insert into cities_cost values (5, 'b', 'c', 35);
insert into cities_cost values (6, 'b', 'd', 25);

insert into cities_cost values (7, 'c', 'a', 15);
insert into cities_cost values (8, 'c', 'b', 35);
insert into cities_cost values (9, 'c', 'd', 30);

insert into cities_cost values (10, 'd', 'a', 20);
insert into cities_cost values (11, 'd', 'b', 25);
insert into cities_cost values (12, 'd', 'c', 30);