CREATE MATERIALIZED VIEW mv_dmitriy_visits_and_eats AS
SELECT DISTINCT pz.name
FROM person_visits pv
JOIN pizzeria pz ON pv.pizzeria_id = pz.id
JOIN menu m ON pz.id = m.pizzeria_id
WHERE pv.person_id = (SELECT id FROM person WHERE name = 'Dmitriy')
	AND pv.visit_date = '2022-01-08'
    AND m.price < 800;