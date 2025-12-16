# GameVault Database

Dijital oyun dağıtım platformu için veritabanı tasarımı (Örn. Steam)

![Database Schema](./schema.jpg)

Schema link: https://drawsql.app/teams/-6327/diagrams/gamevault-database

## ✓ Tamamlanan Görevler

- **DDL:** 4 tablo oluşturuldu (developers, games, genres, games_genres)
- **FK/İlişkiler:** 1-to-Many ve Many-to-Many tanımlandı (CASCADE)
- **DML:** 5 geliştirici, 5 tür, 10 oyun, 18 ilişki eklendi
- **UPDATE/DELETE:** %10 indirim, puan güncelleme, Fallout 4 silindi
- **SELECT/JOIN:** Tüm oyunlar, RPG filtresi, 500+ fiyat analizi, "War" araması

## Tablo Özeti

- `developers`: id (SERIAL, PK), company_name, country, founded_year
- `games`: id (SERIAL, PK), title, price, release_date, rating, developer_id (FK)
- `genres`: id (SERIAL, PK), name (UNIQUE), description
- `games_genres`: id (SERIAL, PK), game_id (FK), genre_id (FK), UNIQUE (game_id, genre_id)
