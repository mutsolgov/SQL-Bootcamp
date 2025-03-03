SELECT pizzeria_name
FROM (
  SELECT
  	p2.name AS pizzeria_name,
  	COUNT(*) AS female_visits,
  	0 AS male_visits
  FROM person p
  INNER JOIN person_visits pv ON p.id = pv.person_id
  INNER JOIN pizzeria p2 ON pv.pizzeria_id = p2.id
  WHERE p.gender = 'female'
  GROUP BY p2.name
  
  UNION ALL
  
  SELECT
  	p2.name AS pizzeria_name,
  	0 AS female_visits,
  	COUNT(*) AS male_visits
  FROM person p
  INNER JOIN person_visits pv ON p.id = pv.person_id
  INNER JOIN pizzeria p2 ON pv.pizzeria_id = p2.id
  WHERE p.gender = 'male'
  GROUP BY p2.name
) aggregated
GROUP BY pizzeria_name
HAVING SUM(female_visits) > SUM(male_visits)
	OR SUM(male_visits) > SUM(female_visits)
ORDER BY pizzeria_name;