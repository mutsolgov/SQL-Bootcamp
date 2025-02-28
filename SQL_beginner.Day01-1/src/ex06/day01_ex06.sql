SELECT
	action_date,
    person_name
from (
  	SELECT
  		po.order_date as action_date,
  		(SELECT name
         from person
         where person.id = po.person_id) as person_name
  	from person_order po
  	where exists (
      	select 1
      	from person_visits pv
      	where pv.person_id = po.person_id
      		and pv.visit_date = po.order_date
    )
  ) as unique_data
  group by action_date, person_name
  order by action_date asc, person_name desc;