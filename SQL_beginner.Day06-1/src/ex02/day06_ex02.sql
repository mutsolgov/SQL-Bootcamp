SELECT
	p.name,
	m.pizza_name,
	m.price,
	ROUND(m.price * (1 - COALESCE(pd.discount, 0) / 100),2) AS discount_price,
	piz.name AS pizzeria_name
FROM person_order po
JOIN menu m ON po.menu_id = m.id
JOIN pizzeria piz ON m.pizzeria_id = piz.id
JOIN person p ON po.person_id = p.id
LEFT JOIN person_discounts pd ON po.person_id = pd.person_id AND piz.id = pd.pizzeria_id
ORDER BY p.name, m.pizza_name;