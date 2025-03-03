SELECT 
	m.pizza_name,
	m.price,
    (SELECT pz.name FROM pizzeria PZ WHERE pz.id = m.pizzeria_id) AS pizzeria_name
FROM 
	menu m
WHERE 
	m.id NOT IN (
    SELECT po.menu_id
    FROM person_order po
)
ORDER BY 
	m.pizza_name ASC,
    m.price ASC;