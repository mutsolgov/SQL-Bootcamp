SELECT g.generated_date AS missing_date
FROM v_generated_dates g
LEFT JOIN person_visits pv ON g.generated_date = pv.visit_date
WHERE pv.visit_date IS NULL
ORDER BY missing_date;