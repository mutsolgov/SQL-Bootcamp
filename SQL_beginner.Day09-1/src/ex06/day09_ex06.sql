CREATE OR REPLACE FUNCTION fnc_person_visits_and_eats_on_date(
	IN pperson VARCHAR DEFAULT 'Dmitriy',
	IN pprice INTEGER DEFAULT 500,
	IN pdate DATE DEFAULT '2022-01-08'
)
RETURNS TABLE (pizzeria_name VARCHAR)
AS $$
BEGIN
	RETURN QUERY
	SELECT pz.name
	FROM person_visits pv
	JOIN pizzeria pz ON pv.pizzeria_id = pz.id
	JOIN person pr ON pv.person_id = pr.id
	JOIN menu m ON m.pizzeria_id = pz.id
	WHERE pr.name = pperson
		AND pv.visit_date = pdate
		AND m.price < pprice;
END;
$$ LANGUAGE plpgsql;


select * from fnc_person_visits_and_eats_on_date(pprice := 800);

select * from fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');


-- select * from fnc_person_visits_and_eats_on_date(pprice := 800);

-- select * from fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');