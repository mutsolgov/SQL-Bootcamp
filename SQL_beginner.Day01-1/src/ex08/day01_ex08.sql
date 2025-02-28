SELECT
	po.order_date,
    CONCAT(p.name, ' (age:', p.age, ')') AS person_information
FROM
    person_order po
NATURAL JOIN
	(SELECT p.id AS person_id,
     	name,
     	age
     FROM person p) AS p
order BY
    po.order_date ASC,
    person_information ASC;