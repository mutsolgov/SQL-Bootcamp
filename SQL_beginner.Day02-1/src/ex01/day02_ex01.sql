SELECT
	gs.missing_date::DATE AS missing_date
FROM
	generate_series('2022-01-01'::date, '2022-01-10'::date, '1 day') AS gs(missing_date)
LEFT JOIN
    person_visits pv
ON
	gs.missing_date = pv.visit_date AND pv.person_id IN (1, 2)
WHERE
    pv.visit_date is NULL
ORDER BY
    gs.missing_date ASC;