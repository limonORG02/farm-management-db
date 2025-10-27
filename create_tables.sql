-- Создание таблицы с информацией о фермах
CREATE TABLE IF NOT EXISTS farms (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    location TEXT,
    owner TEXT
);

-- Создание таблицы с информацией о культурах
CREATE TABLE IF NOT EXISTS crops (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    type TEXT,
    growing_season TEXT
);

-- Создание таблицы с информацией о почвах
CREATE TABLE IF NOT EXISTS soils (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type TEXT NOT NULL,
    ph_level REAL,
    fertility TEXT
);

-- Создание таблицы с урожайностью (связи между фермами, культурами и почвой)
CREATE TABLE IF NOT EXISTS yields (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    farm_id INTEGER,
    crop_id INTEGER,
    soil_id INTEGER,
    harvest_year INTEGER,
    yield_amount REAL,
    FOREIGN KEY (farm_id) REFERENCES farms(id),
    FOREIGN KEY (crop_id) REFERENCES crops(id),
    FOREIGN KEY (soil_id) REFERENCES soils(id)
);
