# SQL Bootcamp — День 07

## Задание: Аггрегированные данные — это более информативно!


### Описание задания
Сегодня будем учиться использовать специфические OLAP-конструкции для получения значений из данных.

### Содержание
- **Глава I**: Упражнение 00 — Простая агрегация информации
- **Глава II**: Упражнение 01 — Давайте увидим реальные имена
- **Глава III**: Упражнение 02 — Статистика ресторанов
- **Глава IV**: Упражнение 03 — Статистика ресторанов #2
- **Глава V**: Упражнение 04 — Группировка с использованием HAVING
- **Глава VI**: Упражнение 05 — Уникальность личности
- **Глава VII**: Упражнение 06 — Метрики ресторанов
- **Глава VIII**: Упражнение 07 — Средний глобальный рейтинг
- **Глава IX**: Упражнение 08 — Поиск локаций пиццерий
- **Глава X**: Упражнение 09 — Явное преобразование типов

---

## Реализованные решения

### Глава I — Упражнение 00: Простая агрегация информации
### Задача: Написать SQL-запрос, который возвращает идентификаторы людей и количество их посещений пиццерий, отсортированных по количеству посещений в убывающем порядке и по идентификатору человека в возрастающем порядке.

**Наш код**:
```sql
SELECT
    person_id,
    COUNT(*) AS count_of_visits
FROM person_visits
GROUP BY person_id
ORDER BY count_of_visits DESC, person_id ASC;
```



## Глава II — Упражнение 01: Давайте увидим реальные имена
### Задача: Изменить запрос из предыдущего упражнения, чтобы выводились имена людей, а не их идентификаторы. Также нужно отобразить только топ-4 человека с максимальным количеством посещений в каждой пиццерии, отсортировав по имени.

## Наш код:
```sql
SELECT 
    p.name AS name,
    COUNT(*) AS count_of_visits
FROM person_visits pv
JOIN person p ON pv.person_id = p.id
GROUP BY p.name
ORDER BY count_of_visits DESC, p.name ASC
LIMIT 4;
```



## Глава III — Упражнение 02: Статистика ресторанов
### Задача: Написать запрос, который возвращает 3 самые популярные рестораны по количеству посещений и заказов, добавив колонку action_type, которая будет содержать значения 'order' или 'visit'. Результаты нужно отсортировать сначала по action_type, а затем по count в убывающем порядке.

### Наш код:
```sql
(
    SELECT
        pz.name AS name,
        COUNT(*) AS count,
        'order' AS action_type
    FROM person_order po
    JOIN menu m ON po.menu_id = m.id
    JOIN pizzeria pz ON m.pizzeria_id = pz.id
    GROUP BY pz.name
    ORDER BY count DESC
    LIMIT 3
)
UNION
(
    SELECT
        pz.name AS name,
        COUNT(*) AS count,
        'visit' AS action_type
    FROM person_visits pv
    JOIN pizzeria pz ON pv.pizzeria_id = pz.id
    GROUP BY pz.name
    ORDER BY count DESC
    LIMIT 3
)
ORDER BY action_type ASC, count DESC;
```


## Глава IV — Упражнение 03: Статистика ресторанов #2
### Задача: Написать SQL-запрос, который группирует рестораны по количеству посещений и заказов, объединяет их по названию пиццерии, вычисляет общую сумму заказов и посещений и сортирует результаты по общей сумме в убывающем порядке и по названию в возрастающем порядке.

### Наш код:

```sql
SELECT
    pz.name AS NAME,
    COALESCE(o.count, 0) + COALESCE(v.count, 0) AS total_count
FROM pizzeria pz
LEFT JOIN (
    SELECT
        pz.name AS name,
        COUNT(*) AS count
    FROM person_order po
    JOIN menu m ON po.menu_id = m.id
    JOIN pizzeria pz ON m.pizzeria_id = pz.id
    GROUP BY pz.name
) o ON pz.name = o.name
LEFT JOIN (
    SELECT
        pz.name AS name,
        COUNT(*) AS count
    FROM person_visits pv
    JOIN pizzeria pz ON pv.pizzeria_id = pz.id
    GROUP BY pz.name
) v ON pz.name = v.name
ORDER BY total_count DESC, name ASC;
```


## Глава V — Упражнение 04: Группировка с использованием HAVING
### Задача: Написать SQL-запрос, который возвращает имена людей и количество их посещений пиццерий, если человек посетил пиццерию больше трех раз.

### Наш код:
```sql
SELECT
    p.name AS name,
    COUNT(*) AS count_of_visits
FROM person_visits pv
JOIN person p ON pv.person_id = p.id
GROUP BY p.name
HAVING COUNT(*) > 3
ORDER BY p.name;
```


## Глава VI — Упражнение 05: Уникальность личности
### Задача: Написать запрос, который возвращает уникальные имена людей, которые сделали заказы в пиццериях.

### Наш код:
```sql
SELECT DISTINCT p.name
FROM person_order po
JOIN person p ON po.person_id = p.id
ORDER BY p.name;
```


## Глава VII — Упражнение 06: Метрики ресторанов
### Задача: Написать запрос, который возвращает количество заказов, среднюю цену, максимальную и минимальную цену пицц, проданных в каждом ресторане. Результат должен быть отсортирован по имени ресторана.

### Наш код:
```sql
SELECT
    pz.name AS name,
    COUNT(po.id) AS count_of_orders,
    ROUND(AVG(m.price), 2) AS average_price,
    MAX(m.price) AS max_price,
    MIN(m.price) AS min_price
FROM person_order po
JOIN menu m ON po.menu_id = m.id
JOIN pizzeria pz ON m.pizzeria_id = pz.id
GROUP BY pz.name
ORDER BY pz.name;
```


## Глава VIII — Упражнение 07: Средний глобальный рейтинг
### Задача: Написать SQL-запрос, который возвращает общий средний рейтинг всех ресторанов. Рейтинг должен быть округлен до 4 знаков после запятой.

### Наш код:
```sql
SELECT ROUND(AVG(rating), 4) AS global_rating
FROM pizzeria;
```

## Глава IX — Упражнение 08: Поиск локаций пиццерий
### Задача: Написать SQL-запрос, который возвращает адрес, название пиццерии и количество заказов, сделанных этим человеком в данном ресторане. Результат должен быть отсортирован по адресу и по названию ресторана.

### Наш код:
```sql
SELECT
    p.address,
    pz.name AS name,
    COUNT(po.id) AS count_of_orders
FROM person_order po
JOIN person p ON po.person_id = p.id
JOIN menu m ON po.menu_id = m.id
JOIN pizzeria pz ON m.pizzeria_id = pz.id
GROUP BY p.address, pz.name
ORDER BY p.address, pz.name;
```

## Глава X — Упражнение 09: Явное преобразование типов
### Задача: Написать SQL-запрос, который возвращает агрегацию по адресу человека, вычисляя формулу: MAX(age) - (MIN(age) / MAX(age)) и сравнивая ее с средней возрастной категорией по адресу.

### Наш код:
```sql
SELECT
    address,
    ROUND(MAX(age) - (MIN(age) / MAX(age::numeric)), 2) AS formula,
    ROUND(AVG(age), 2) AS average,
    (ROUND(MAX(age) - (MIN(age) / MAX(age)), 2) > ROUND(AVG(age), 2)) AS comparison
FROM person
GROUP BY address
ORDER BY address;
```



## Заключение
### В ходе выполнения данного проекта мы научились использовать различные SQL-конструкции для агрегации данных и их обработки. Мы научились решать задачи, связанные с агрегацией, фильтрацией, сортировкой, а также научились использовать функции для работы с числами и датами.


