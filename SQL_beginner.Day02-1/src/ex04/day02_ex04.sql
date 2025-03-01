SELECT
	m.pizza_name,
	pz.name AS pizzeria_name,
    m.price
FROM
	menu M
JOIN
	pizzeria pz
ON
	m.pizzeria_id = pz.id
WHERE
	m.pizza_name IN ('mushroom pizza', 'pepperoni pizza')
ORDER BY
	m.pizza_name asc,
    pz.name asc;