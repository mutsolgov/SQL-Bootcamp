## 📈 SQL Bootcamp — Day 05: Indexing Matters
### Добро пожаловать в пятый день SQL Bootcamp! В этом этапе я углубился в работу с индексами в PostgreSQL и улучшил производительность SQL-запросов. Целью было понять, как индексирование может ускорить выборку данных и какие бывают типы индексов: обычные, составные, уникальные, частично уникальные, а также функциональные.

## 📚 Содержание проекта
### Проект включает 7 упражнений:

- Создание индексов по внешним ключам

- Проверка работы индексов

- Функциональный индекс

- Составной индекс

- Уникальный индекс

- Частично уникальный индекс

- Улучшение производительности сложного запроса

## 🔧 Упражнения и реализованные решения
### 🟢 Exercise 00 — Индексы на внешние ключи
### Создал B-Tree индексы для всех внешних ключей:

```sql
CREATE INDEX idx_menu_pizzeria_id ON menu(pizzeria_id);
CREATE INDEX idx_person_visits_person_id ON person_visits(person_id);
CREATE INDEX idx_person_visits_pizzeria_id ON person_visits(pizzeria_id);
CREATE INDEX idx_person_order_person_id ON person_order(person_id);
CREATE INDEX idx_person_order_menu_id ON person_order(menu_id);
```
### 🟢 Exercise 01 — Проверка работы индексов
### С помощью EXPLAIN ANALYZE и SET enable_seqscan = OFF доказал, что индекс используется:

```sql
SET enable_seqscan = OFF;
EXPLAIN ANALYZE
SELECT m.pizza_name, p.name AS pizzeria_name
FROM menu m
JOIN pizzeria p ON p.id = m.pizzeria_id;
```

### 🟢 Exercise 02 — Функциональный индекс
### Создал индекс на UPPER(name) и убедился в его использовании:

```sql
CREATE INDEX idx_person_name ON person USING btree (UPPER(name));
SET enable_seqscan = OFF;
EXPLAIN ANALYZE
SELECT * FROM person WHERE UPPER(name) = 'Kate';
```

### 🟢 Exercise 03 — Составной индекс
### Создал мультиколоночный индекс и проверил работу Index Only Scan:

```sql
CREATE INDEX idx_person_order_multi ON person_order USING btree (person_id, menu_id, order_date);
SET enable_seqscan = OFF;
EXPLAIN ANALYZE
SELECT person_id, menu_id, order_date
FROM person_order
WHERE person_id = 8 AND menu_id = 19;
```

### 🟢 Exercise 04 — Уникальный индекс
### Создал уникальный индекс на пару pizzeria_id, pizza_name:

```sql
CREATE UNIQUE INDEX idx_menu_unique ON menu USING btree (pizzeria_id, pizza_name);
SET enable_seqscan = OFF;
EXPLAIN ANALYZE
SELECT * FROM menu
WHERE pizzeria_id = 4 AND pizza_name = 'supreme pizza';
```

### 🟢 Exercise 05 — Частичная уникальность
### Создал частично уникальный индекс, ограниченный определённой датой:

```sql
CREATE UNIQUE INDEX idx_person_order_order_date
ON person_order USING btree (person_id, menu_id)
WHERE order_date = '2022-01-01';
SET enable_seqscan = OFF;
EXPLAIN ANALYZE
SELECT person_id, menu_id
FROM person_order
WHERE order_date = '2022-01-01';
```

### 🟢 Exercise 06 — Оптимизация сложного запроса
### Создал индекс idx_1, который ускорил выполнение запроса с оконной функцией:

```sql
CREATE INDEX idx_1 ON pizzeria USING btree (rating);
SET enable_seqscan = OFF;
EXPLAIN ANALYZE
SELECT
    m.pizza_name AS pizza_name,
    max(rating) OVER (
        PARTITION BY rating 
        ORDER BY rating 
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS k
FROM  menu m
INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
ORDER BY 1,2;
```

### ✅ Вывод
### 📌 Индексы — мощный инструмент оптимизации SQL-запросов. Даже простые B-Tree индексы могут значительно ускорить выборку, особенно на больших объёмах данных. В этом проекте я освоил:

- Создание и именование индексов по шаблону

- Использование EXPLAIN ANALYZE для анализа производительности

- Функциональные, составные, уникальные и частично уникальные индексы

- Трюки вроде SET enable_seqscan = OFF для принудительного использования индексов

### 🚀 Используемые технологии
- PostgreSQL

- ANSI SQL

- EXPLAIN ANALYZE

### 📂 Структура проекта
```pgsql
├── ex00
│   └── day05_ex00.sql
├── ex01
│   └── day05_ex01.sql
├── ex02
│   └── day05_ex02.sql
├── ex03
│   └── day05_ex03.sql
├── ex04
│   └── day05_ex04.sql
├── ex05
│   └── day05_ex05.sql
├── ex06
│   └── day05_ex06.sql
└── README.md
```