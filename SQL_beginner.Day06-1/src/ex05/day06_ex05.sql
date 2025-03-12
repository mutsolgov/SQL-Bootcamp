COMMENT ON TABLE person_discounts IS 'Таблица хранит информацию о персональных скидках клиентов в пецериях.';
COMMENT ON COLUMN person_discounts.id IS 'Уникальный идентификатор записи.';
COMMENT ON COLUMN person_discounts.person_id IS 'Идентификатор клиента, которому предоставлена скидка.';
COMMENT ON COLUMN person_discounts.pizzeria_id IS 'Идентификатор пиццерии, где предоставляется скидка.';
COMMENT ON COLUMN person_discounts.discount IS 'Размер персональной скидки в процентах (от 0 до 100).';