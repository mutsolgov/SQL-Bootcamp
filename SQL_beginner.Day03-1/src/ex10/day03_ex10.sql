INSERT INTO person_order (id, person_id, menu_id, order_date)
VALUES
    (
        (SELECT MAX(id) + 1 FROM person_order),
        (SELECT id FROM person WHERE name = 'Denis'),
        (SELECT m.id FROM menu m
         JOIN pizzeria pz ON m.pizzeria_id = pz.id
         WHERE m.pizza_name = 'sicilian pizza' AND pz.name = 'Dominos'
         LIMIT 1),
         '2022-02-24'
    ),
    (
        (SELECT MAX(id) + 2 FROM person_order),
        (SELECT id FROM person WHERE name = 'Irina'),
        (SELECT m.id FROM menu m
         JOIN pizzeria pz ON m.pizzeria_id = pz.id
         WHERE m.pizza_name = 'sicilian pizza' AND pz.name = 'Dominos'
         LIMIT 1),
         '2022-02-24'
    );