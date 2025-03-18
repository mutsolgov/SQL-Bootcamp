INSERT INTO currency values (100, 'EUR', 0.85, '2022-01-01 13:29');
INSERT INTO currency values (100, 'EUR', 0.79, '2022-01-08 13:29');


WITH last_rates AS
		(SELECT crn.name AS currency_name,
           		b.money,
				b.currency_id,
                b.user_id,
				COALESCE(
	                (
	                    SELECT rate_to_usd
	                    FROM currency c
	                    WHERE b.currency_id = c.id
	                        AND c.updated < b.updated
	                    ORDER BY c.updated desc
	                    LIMIT 1
	                ), (
	                    SELECT rate_to_usd
	                    FROM currency c
	                    WHERE b.currency_id = c.id
	                        AND c.updated > b.updated
	                    ORDER BY c.updated asc
	                    LIMIT 1
	                )
	            ) AS rate_to_usd
	     FROM balance b
		 	JOIN (
				SELECT c.id,
                    c.name
                FROM currency c
                GROUP BY c.id, c.name) AS crn ON crn.id = b.currency_id)

SELECT COALESCE(u.name, 'not defined') AS name,
		COALESCE(u.lastname, 'not defined') AS lastname,
		lr.currency_name,
		CAST(money * rate_to_usd AS float) AS currency_in_usd
FROM "user" u
RIGHT JOIN last_rates lr ON lr.user_id = u.id
ORDER BY name DESC, lastname, currency_name;