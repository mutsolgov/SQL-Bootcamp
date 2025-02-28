SELECT object_name
FROM (
    SELECT
        name AS object_name,
        'person' AS SOURCE
    FROM person
    UNION ALL
    SELECT
        pizza_name AS object_name,
        'menu' AS SOURCE
    FROM menu
) AS combined
ORDER BY
    CASE
        WHEN SOURCE = 'person' THEN 1
        WHEN SOURCE = 'menu' THEN 2
    END,
    object_name;