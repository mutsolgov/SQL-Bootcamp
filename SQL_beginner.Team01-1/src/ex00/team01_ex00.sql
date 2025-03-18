WITH last_rates AS (
        SELECT * FROM balance
        FULL JOIN
        (SELECT DISTINCT ON (id) *
        FROM currency
        ORDER BY id, updated DESC) AS c ON c.id = balance.currency_id),

    volume_sum AS (
        SELECT
            user_id,
            SUM(money) AS volume,
            type,
            COALESCE(name, 'not defined') AS currency_name,
            COALESCE(rate_to_usd, 1) AS last_rate_to_usd
        FROM last_rates
        GROUP BY user_id, type, currency_name, rate_to_usd)

SELECT
    COALESCE(u.name, 'not defined') as name,
    COALESCE(u.lastname, 'not defined') as lastname,
    vs.type,
    vs.volume,
    vs.currency_name,
    vs.last_rate_to_usd,
    CAST(vs.volume * last_rate_to_usd as FLOAT) AS total_volume_in_usd
FROM "user" u
FULL JOIN volume_sum vs ON u.id = vs.user_id
ORDER BY name DESC, lastname, type;