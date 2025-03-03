SELECT DISTINCT pz.name AS pizzeria_name
FROM person p
INNER JOIN person_visits pv ON p.id = pv.person_id
INNER JOIN pizzeria pz ON pv.pizzeria_id = pz.id
WHERE p.name = 'Andrey'
AND pz.id NOT in (
  SELECT DISTINCT pz2.id
  FROM person p2
  INNER JOIN person_order po ON p2.id = po.person_id
  INNER JOIN menu m ON po.menu_id = m.id
  INNER join pizzeria pz2 ON m.pizzeria_id = pz2.id
  WHERE p2.name = 'Andrey'
)
order by pizzeria_name;