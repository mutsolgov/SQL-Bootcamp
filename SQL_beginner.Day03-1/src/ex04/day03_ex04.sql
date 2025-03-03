SELECT DISTINCT pz.name AS pizzeria_name
FROM person p
INNER JOIN person_order po ON p.id = po.person_id
INNER JOIN menu m ON po.menu_id = m.id
INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
WHERE p.gender = 'female'
AND pz.id NOT IN (
  SELECT DISTINCT pz2.id
  FROM person p2
  INNER JOIN person_order po2 On p2.id = po2.person_id
  INNER JOIN menu m2 ON po2.menu_id = m2.id
  INNER JOIN pizzeria pz2 ON m2.pizzeria_id = pz2.id
  WHERE p2.gender = 'male')
UNION
SELECT DISTINCT pz.name AS pizzeria_name
FROM person p
INNER JOIN person_order po ON p.id = po.person_id
INNER JOIN menu m ON po.menu_id = m.id
INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
WHERE p.gender = 'male'
AND pz.id NOT IN (
  SELECT DISTINCT pz2.id
  FROM person p2
  INNER JOIN person_order po2 ON p2.id = po2.person_id
  INNER JOIN menu m2 ON po2.menu_id = m2.id
  INNER JOIN pizzeria pz2 ON m2.pizzeria_id = pz2.id
  WHERE p2.gender = 'female')
ORDER BY pizzeria_name;