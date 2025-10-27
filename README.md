##  Farm Management Database

**Farm Management Database** — это учебный проект, демонстрирующий работу с реляционной базой данных для управления информацией о фермах, сельскохозяйственных культурах, типах почв и урожайности.  
База данных реализована на **SQLite** и служит примером архитектуры для небольших аграрных систем учёта.

---

### Структура проекта
```
farm-management-db/
│
├── create_tables.sql # Скрипт создания таблиц
├── insert_data.sql # Скрипт вставки данных
├── queries.sql # Примеры SQL-запросов
└── README.md # Описание проекта
```

---

### Установка и запуск

#### Установить SQLite

**Linux (Ubuntu / Debian):**
```bash
sudo apt install sqlite3
```
Arch Linux / Manjaro:
```
sudo pacman -S sqlite
```
Windows:

Скачайте архив с официального сайта SQLite

Распакуйте, например, в C:\sqlite

Откройте командную строку (Win + R → cmd)

Перейдите в папку:
```
cd C:\sqlite
```
Запустите SQLite:
```
sqlite3 farm.db
```
### Создать базу данных

```
sqlite3 farm.db < create_tables.sql
sqlite3 farm.db < insert_data.sql
```
### Проверить содержимое

```bash
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

### Связи между таблицами:

Каждая запись в yields связана с конкретной фермой (farm_id), культурой (crop_id) и почвой (soil_id).

### Архитектура базы данных

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

## Примеры SQL-запросов
### Просмотр всех ферм и их культур

```sql
SELECT f.name AS farm, c.name AS crop, y.harvest_year, y.yield_amount
FROM yields y
JOIN farms f ON y.farm_id = f.id
JOIN crops c ON y.crop_id = c.id;
```

### Средняя урожайность по культурам

```sql
SELECT c.name, AVG(y.yield_amount) AS avg_yield
FROM yields y
JOIN crops c ON y.crop_id = c.id
GROUP BY c.name;
```
### Список культур с высокой урожайностью (>3000)

```sql

SELECT c.name, y.yield_amount
FROM yields y
JOIN crops c ON y.crop_id = c.id
WHERE y.yield_amount > 3000;
```

### Автор проекта
Рахматиллаева Хосият
Ташкентский государственный аграрный университет
Направление: IT в сельском хозяйстве 
