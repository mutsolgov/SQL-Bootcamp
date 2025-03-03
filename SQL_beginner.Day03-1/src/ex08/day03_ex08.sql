INSERT INTO menu (id, pizzeria_id, pizza_name, price)
VALUES (
  (SELECT MAX(id) + 1 FROM menu),
  (select id from pizzeria where name = 'Dominos'),
  'sicilian pizza',
  900
);