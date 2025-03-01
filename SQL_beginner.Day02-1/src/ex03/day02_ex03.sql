WITH day_generator AS (
    SELECT generate_series(
        '2022-01-01'::DATE,
        '2022-01-10'::DATE,
        '1 day'::INTERVAL
    )::DATE AS missing_date
),
visited_days AS (
    SELECT DISTINCT visit_date
    FROM person_visits
    WHERE person_id IN (1, 2)
)
SELECT dg.missing_date
FROM day_generator dg
LEFT JOIN visited_days vd 
ON dg.missing_date = vd.visit_date
WHERE vd.visit_date IS NULL
ORDER BY dg.missing_date;