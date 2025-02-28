SELECT
	po.order_date,
    CONCAT(p.name, ' (age:', p.age, ')') AS person_information
FROM
    person_order po
JOIN
    person p
on
	po.person_id = p.id
order BY
    po.order_date asc,
    person_information asc;