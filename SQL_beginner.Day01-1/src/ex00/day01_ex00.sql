SELECT 
	id AS object_id, 
    pizza_name AS object_name
from menu
UNION ALL
SELECT 
	id AS object_id,
    namE AS object_name
FROM person
ORDER BY object_id, object_name;