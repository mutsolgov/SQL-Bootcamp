SELECT
    m.pizza_name,
    m.price,
    pz.name AS pizzeria_name,
    pv.visit_date
FROM
    person p
JOIN
    person_visits pv ON p.id = pv.person_id
JOIN
    menu m ON pv.pizzeria_id = m.pizzeria_id
JOIN
    pizzeria pz ON m.pizzeria_id = pz.id
WHERE
    p.name = 'Kate'
    AND m.price BETWEEN 800 AND 1000
ORDER BY
    m.pizza_name ASC,
    m.price ASC,
    pz.name ASC;
