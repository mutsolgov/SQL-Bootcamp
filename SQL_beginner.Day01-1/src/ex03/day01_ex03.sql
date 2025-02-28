SELECT order_date as action_date, person_id
FROM person_order
intersect
select visit_date as action_date, person_id
from person_visits
order by 
	action_date ASC,
	person_id DESC;