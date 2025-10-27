#!/bin/bash
# ======================================
# 🌾 Farm Management DB Setup Script
# ======================================

echo " Проверяем наличие SQLite..."
if ! command -v sqlite3 &> /dev/null
then
    echo " Устанавливаем SQLite через pacman..."
    sudo pacman -S --noconfirm sqlite
else
    echo " SQLite уже установлен!"
fi

echo " Создаём базу данных..."
sqlite3 farm.db < create_tables.sql
sqlite3 farm.db < insert_data.sql

echo " Проверяем созданные таблицы:"
sqlite3 farm.db ".tables"

echo " База данных успешно создана!"
echo "Можешь выполнить запросы с помощью:"
echo "sqlite3 farm.db < queries.sql"
