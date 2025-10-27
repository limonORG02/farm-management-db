🌾 Farm Management Database

Farm Management Database — это учебный проект, демонстрирующий работу с реляционной базой данных для управления информацией о фермах, сельскохозяйственных культурах, типах почв и урожайности.
База данных реализована на SQLite и служит примером архитектуры для небольших аграрных систем учёта.

 Структура проекта
```
farm-management-db/
│
├── create_tables.sql      # Скрипт создания таблиц
├── insert_data.sql        # Скрипт вставки данных
├── queries.sql            # Примеры SQL-запросов
└── README.md              # Описание проекта
```
 Установка и запуск
1. Установить SQLite

Linux / macOS
```
sudo apt install sqlite3
```

Windows
Скачать с официального сайта [SQLite](https://sqlite.org/download.html)
.

2. Создать базу данных
```
sqlite3 farm.db < create_tables.sql
sqlite3 farm.db < insert_data.sql
```

3. Проверить содержимое
```
sqlite3 farm.db
sqlite> .tables
sqlite> SELECT * FROM farms;
```
### Структура базы данных

Основные таблицы:

farms — фермерские хозяйства

crops — сельскохозяйственные культуры

soils — типы почв

yields — данные об урожайности

Связи между таблицами:

Каждая запись в yields связана с конкретной фермой (farm_id), культурой (crop_id) и почвой (soil_id).

Архитектура базы данных

```
┌────────────┐       ┌────────────┐
│   farms    │       │   crops    │
│────────────│       │────────────│
│ id (PK)    │       │ id (PK)    │
│ name       │       │ name       │
│ location   │       │ type       │
│ owner      │       │ season     │
└────┬───────┘       └────┬───────┘
     │                    │
     └────────────┬────────┘
                  │
            ┌─────▼─────┐
            │  yields   │
            │───────────│
            │ id (PK)   │
            │ farm_id   │──► farms.id
            │ crop_id   │──► crops.id
            │ soil_id   │──► soils.id
            │ year      │
            │ amount    │
            └────▲──────┘
                 │
          ┌──────┴──────┐
          │   soils     │
          │─────────────│
          │ id (PK)     │
          │ type        │
          │ ph_level    │
          │ fertility   │
          └─────────────┘
```
Примеры SQL-запросов

###  Посмотр всех ферм и их культур
```
SELECT f.name AS farm, c.name AS crop, y.harvest_year, y.yield_amount
FROM yields y
JOIN farms f ON y.farm_id = f.id
JOIN crops c ON y.crop_id = c.id;
```

### Cредняя урожайность по культурам
```
SELECT c.name, AVG(y.yield_amount) AS avg_yield
FROM yields y
JOIN crops c ON y.crop_id = c.id
GROUP BY c.name;
```

### Список культур с высокой урожайностью (>3000)
```
SELECT c.name, y.yield_amount
FROM yields y
JOIN crops c ON y.crop_id = c.id
WHERE y.yield_amount > 3000;
```
