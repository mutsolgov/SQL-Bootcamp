SELECT
	pz.name AS NAME,
	COALESCE(o.count, 0) + COALESCE(v.count, 0) AS total_count
FROM pizzeria pz
LEFT JOIN (
	SELECT
		pz.name AS name,
		COUNT(*) AS count
	FROM person_order po
	JOIN menu m ON po.menu_id = m.id
	JOIN pizzeria pz ON m.pizzeria_id = pz.id
	GROUP BY pz.name
) o ON pz.name = o.name
LEFT JOIN (
	SELECT
		pz.name AS name,
		COUNT(*) AS count
	FROM person_visits pv
	JOIN pizzeria pz ON pv.pizzeria_id = pz.id
	GROUP BY pz.name
) v ON pz.name = v.name
ORDER BY total_count DESC, name ASC;