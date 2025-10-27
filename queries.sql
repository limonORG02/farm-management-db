-- 1. Просмотр урожайности по всем фермам и культурам
SELECT f.name AS farm, c.name AS crop, y.harvest_year, y.yield_amount
FROM yields y
JOIN farms f ON y.farm_id = f.id
JOIN crops c ON y.crop_id = c.id
ORDER BY y.harvest_year DESC;

-- 2. Средняя урожайность по культурам
SELECT c.name AS crop, ROUND(AVG(y.yield_amount), 2) AS avg_yield
FROM yields y
JOIN crops c ON y.crop_id = c.id
GROUP BY c.name
ORDER BY avg_yield DESC;

-- 3. Список ферм, где урожайность выше 3500
SELECT f.name AS farm, y.yield_amount, y.harvest_year
FROM yields y
JOIN farms f ON y.farm_id = f.id
WHERE y.yield_amount > 3500;

-- 4. Почвы с уровнем pH в норме (6.0–7.2)
SELECT * FROM soils
WHERE ph_level BETWEEN 6.0 AND 7.2;

-- 5. Количество культур по сезонам
SELECT growing_season, COUNT(*) AS total_crops
FROM crops
GROUP BY growing_season;
