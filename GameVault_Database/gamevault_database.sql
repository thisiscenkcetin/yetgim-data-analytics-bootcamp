-- GameVault Database
-- Oyun Dağıtım Platformu Veritabanı Tasarımı

-- ========================================
-- BÖLÜM 1: TABLO OLUŞTURMA (DDL - CREATE TABLE)
-- ========================================

-- Geliştiriciler Tablosu
CREATE TABLE developers (
    id SERIAL PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    founded_year INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Oyun Türleri Tablosu
CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255)
);

-- Oyunlar Tablosu
CREATE TABLE games (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    release_date DATE NOT NULL,
    rating DECIMAL(3, 1) CHECK (rating >= 0 AND rating <= 10),
    developer_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (developer_id) REFERENCES developers(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Oyun-Tür İlişkisi (Many-to-Many)
CREATE TABLE games_genres (
    id SERIAL PRIMARY KEY,
    game_id INT NOT NULL,
    genre_id INT NOT NULL,
    FOREIGN KEY (game_id) REFERENCES games(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE ON UPDATE CASCADE,
    UNIQUE (game_id, genre_id)
);

-- ========================================
-- BÖLÜM 2: VERİ EKLEME (DML - INSERT)
-- ========================================

-- Geliştirici Firmaları
INSERT INTO developers (company_name, country, founded_year) VALUES
('CD Projekt Red', 'Poland', 2002),
('Rockstar Games', 'United States', 1998),
('Bethesda Game Studios', 'United States', 2001),
('Valve Corporation', 'United States', 1996),
('Bandai Namco Entertainment', 'Japan', 1980);

-- Oyun Türleri
INSERT INTO genres (name, description) VALUES
('RPG', 'Role-Playing Game - Karakteri geliştir ve hikaye seç'),
('Open World', 'Açık Dünya - Özgürce keşfedebileceğin geniş harita'),
('Action', 'Aksiyon - Hızlı refleks ve dövüş mekaniklerine dayalı'),
('FPS', 'First-Person Shooter - Birinci şahıs nişancı oyunları'),
('Sports', 'Spor - Futbol, korida ve diğer spor müsabakalarına dayalı');

-- Oyunlar
INSERT INTO games (title, price, release_date, rating, developer_id) VALUES
-- CD Projekt Red
('The Witcher 3: Wild Hunt', 349.99, '2015-05-19', 9.3, 1),
('Cyberpunk 2077', 299.99, '2020-12-10', 8.5, 1),

-- Rockstar Games
('Grand Theft Auto V', 299.99, '2013-09-17', 9.7, 2),
('Red Dead Redemption 2', 349.99, '2018-10-26', 9.8, 2),

-- Bethesda
('The Elder Scrolls V: Skyrim', 199.99, '2011-11-11', 9.2, 3),
('Fallout 4', 179.99, '2015-11-10', 8.1, 3),

-- Valve
('Counter-Strike 2', 0.00, '2023-09-01', 8.9, 4),
('Half-Life 2', 59.99, '2004-11-16', 8.6, 4),

-- Bandai Namco
('Elden Ring', 449.99, '2022-02-25', 8.7, 5),
('Dark Souls III', 249.99, '2016-04-12', 8.8, 5);

-- 2.4. Oyun-Tür Eşleştirmesi (Many-to-Many)
-- The Witcher 3: RPG + Open World
INSERT INTO games_genres (game_id, genre_id) VALUES
(1, 1), -- The Witcher 3 - RPG
(1, 2), -- The Witcher 3 - Open World

-- Cyberpunk 2077: RPG + Action
(2, 1), -- Cyberpunk 2077 - RPG
(2, 3), -- Cyberpunk 2077 - Action

-- GTA V: Action + Open World
(3, 3), -- GTA V - Action
(3, 2), -- GTA V - Open World

-- Red Dead Redemption 2: Action + Open World
(4, 3), -- RDR 2 - Action
(4, 2), -- RDR 2 - Open World

-- Skyrim: RPG + Open World
(5, 1), -- Skyrim - RPG
(5, 2), -- Skyrim - Open World

-- Fallout 4: RPG + Action
(6, 1), -- Fallout 4 - RPG
(6, 3), -- Fallout 4 - Action

-- Counter-Strike 2: FPS + Action
(7, 4), -- CS2 - FPS
(7, 3), -- CS2 - Action

-- Half-Life 2: FPS + Action
(8, 4), -- HL2 - FPS
(8, 3), -- HL2 - Action

-- Elden Ring: RPG + Action
(9, 1), -- Elden Ring - RPG
(9, 3), -- Elden Ring - Action

-- Dark Souls III: RPG + Action
(10, 1), -- DS III - RPG
(10, 3); -- DS III - Action

-- ========================================
-- GÜNCELLEME VE SİLME
-- ========================================

UPDATE games 
SET price = price * 0.90 
WHERE price > 0;

UPDATE games 
SET rating = 9.5 
WHERE title = 'The Witcher 3: Wild Hunt';

DELETE FROM games 
WHERE title = 'Fallout 4';

-- ========================================
-- RAPORLAMA (SELECT & JOIN)
-- ========================================

-- Tüm Oyunlar Listesi
SELECT 
    g.title AS "Oyun Adı",
    '₺' || TO_CHAR(g.price, '9999.99') AS "Fiyat",
    d.company_name AS "Geliştirici Firma",
    g.rating AS "Puan"
FROM games g
INNER JOIN developers d ON g.developer_id = d.id
ORDER BY g.title ASC;

-- RPG Oyunları
SELECT DISTINCT
    g.title AS "Oyun Adı",
    g.rating AS "Puan",
    gen.name AS "Tür"
FROM games g
INNER JOIN games_genres gg ON g.id = gg.game_id
INNER JOIN genres gen ON gg.genre_id = gen.id
WHERE gen.name = 'RPG'
ORDER BY g.rating DESC;

-- Pahalı Oyunlar (500 TL+)
SELECT 
    g.title AS "Oyun Adı",
    '₺' || TO_CHAR(g.price, '9999.99') AS "Fiyat",
    d.company_name AS "Geliştirici",
    g.release_date AS "Çıkış Tarihi"
FROM games g
INNER JOIN developers d ON g.developer_id = d.id
WHERE g.price >= 500
ORDER BY g.price DESC;

-- "War" içeren oyunlar
SELECT 
    g.title AS "Oyun Adı",
    '₺' || TO_CHAR(g.price, '9999.99') AS "Fiyat",
    d.company_name AS "Geliştirici",
    g.rating AS "Puan"
FROM games g
INNER JOIN developers d ON g.developer_id = d.id
WHERE g.title LIKE '%War%'
ORDER BY g.title ASC;

-- ========================================
-- BONUS SORGULAR (:
-- ========================================

SELECT 
    d.company_name AS "Geliştirici Firma",
    COUNT(g.id) AS "Oyun Sayısı",
    AVG(g.rating) AS "Ortalama Puan",
    '₺' || TO_CHAR(SUM(COALESCE(g.price, 0)), '99999.99') AS "Toplam Fiyat"
FROM developers d
LEFT JOIN games g ON d.id = g.developer_id
GROUP BY d.id, d.company_name
ORDER BY COUNT(g.id) DESC;

SELECT
    g.title AS "Oyun Adı",
    g.rating AS "Puan",
    '₺' || TO_CHAR(g.price, '9999.99') AS "Fiyat",
    d.company_name AS "Geliştirici"
FROM games g
INNER JOIN developers d ON g.developer_id = d.id
ORDER BY g.rating DESC
LIMIT 5;

SELECT 
    gen.name AS "Tür",
    COUNT(DISTINCT g.id) AS "Oyun Sayısı",
    AVG(g.rating) AS "Ortalama Puan"
FROM genres gen
LEFT JOIN games_genres gg ON gen.id = gg.genre_id
LEFT JOIN games g ON gg.game_id = g.id
GROUP BY gen.id, gen.name
ORDER BY COUNT(DISTINCT g.id) DESC;

SELECT 
    CASE 
        WHEN g.price = 0 THEN 'Ücretsiz'
        WHEN g.price BETWEEN 0.01 AND 99.99 THEN 'Ucuz (0-99.99 TL)'
        WHEN g.price BETWEEN 100 AND 299.99 THEN 'Orta Fiyat (100-299.99 TL)'
        WHEN g.price >= 300 THEN 'Pahalı (300+ TL)'
    END AS "Fiyat Kategorisi",
    COUNT(*) AS "Oyun Sayısı",
    AVG(g.rating) AS "Ortalama Puan"
FROM games g
GROUP BY 
    CASE 
        WHEN g.price = 0 THEN 'Ücretsiz'
        WHEN g.price BETWEEN 0.01 AND 99.99 THEN 'Ucuz (0-99.99 TL)'
        WHEN g.price BETWEEN 100 AND 299.99 THEN 'Orta Fiyat (100-299.99 TL)'
        WHEN g.price >= 300 THEN 'Pahalı (300+ TL)'
    END
ORDER BY MIN(g.price);

-- Veri Kontrolü
SELECT * FROM developers;
SELECT * FROM genres;
SELECT COUNT(*) AS "Toplam Oyun Sayısı" FROM games;
SELECT COUNT(*) AS "Toplam İlişki Sayısı" FROM games_genres;
