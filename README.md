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
### Проверка проекта (Linux / macOS / Arch)
#### ШАГ 1. Проверка SQLite

Проверь, установлен ли SQLite:
```
sqlite3 --version
```
Если выводит что-то вроде:
```
3.45.2 2024-02-15
```
— значит всё ок ✅

Если выдаёт ошибку, установи SQLite:
```
sudo pacman -S sqlite
```
#### ШАГ 2. Перейди в папку проекта
```
cd ~/farm-management-db
```
(или куда ты сохранил проект)

#### ШАГ 3. Сделай setup.sh исполняемым
```
chmod +x setup.sh
```
#### ШАГ 4. Запусти установку
```
./setup.sh
```

Скрипт:

Проверит наличие SQLite

Создаст базу данных farm.db

Применит скрипты create_tables.sql и insert_data.sql

Выведет список таблиц, если всё успешно

Если ты видишь что-то вроде:
SQLite уже установлен!
Проверяем созданные таблицы:
```
crops  farms  soils  yields
```
База данных успешно создана!

#### ШАГ 5. Проверка вручную

Запусти SQLite:
```
sqlite3 farm.db
```
  Проверить таблицы:
```
.tables
```
Ожидаешь увидеть:
```
crops  farms  soils  yields
```
 Проверить данные:
```
SELECT * FROM farms;
```

Ожидаемый результат:
```
1|GreenField|Ташкентская область|Ахмадов И.
2|AgroPlus|Самаркандская область|Каримов Р.
3|EcoFarm|Бухарская область|Юсупов Н.
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
