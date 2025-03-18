WITH RECURSIVE tours AS (
  SELECT
  	ARRAY['a'::varchar] AS tour,
  	0 AS cost,
  	'a'::varchar AS CURRENT
  UNION ALL
  SELECT
  	t.tour || cc.point2,
  	t.cost + cc.cost,
  	cc.point2
  FROM tours t
  JOIN cities_cost cc ON cc.point1 = t.current
  WHERE
  	cc.point2 <> 'a'
  	AND NOT (cc.point2 = ANY(t.tour))
  	AND array_length(t.tour, 1) < (SELECT COUNT(*) FROM cities)
),
complete_tours AS (
  SELECT
  	t.tour || 'a'::varchar AS tour,
  	t.cost + cc.cost AS total_cost
  FROM tours t
  JOIN cities_cost cc ON cc.point1 = t.current AND cc.point2 = 'a'
  WHERE array_length(t.tour, 1) = (SELECT COUNT(*) FROM cities)
)
SELECT total_cost, tour
FROM complete_tours
ORDER BY total_cost, tour;