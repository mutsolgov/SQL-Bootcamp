SELECT 
	person.id as person_id,
    person.name as persone_name,
    person.age,
    person.gender,
    person.address,
    pizzeria.id as pizzeria_id,
    pizzeria.name as pizzeria_name,
    pizzeria.rating
FROM person, pizzeria
order by person.id, pizzeria.id