SELECT
	address,
	ROUND(MAX(age) - (MIN(age) / MAX(age::numeric)), 2) AS formula,
	ROUND(AVG(age), 2) AS average,
	(ROUND(MAX(age) - (MIN(age) / MAX(age)), 2) > ROUND(AVG(age), 2)) AS comparison
FROM person
GROUP BY address
ORDER BY address;