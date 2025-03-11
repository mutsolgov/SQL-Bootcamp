CREATE UNIQUE INDEX idx_menu_unique
ON menu USING btree (pizzeria_id, pizza_name);
SET enable_seqscan = OFF;
EXPLAIN ANALYZE
SELECT *
FROM menu
WHERE pizzeria_id = 4 AND pizza_name = 'supreme pizza';