# Hava Durumu Veri Analizi Projesi

Bu proje, Türkiye'nin farklı şehirlerinden toplanan hava durumu verilerini Pandas ve Numpy kütüphanelerini kullanarak analiz etmektedir.


**Dosya:** `weather_data.csv`


## Tamamlanan Görevler

### 1️⃣ Kütüphane ve Veri Yükleme
- Pandas ve Numpy import edildi
- CSV dosyası DataFrame'e yüklendi

### 2️⃣ Veriyi Keşfetme
- `head()`: İlk 5 satır görüntülendi
- `tail()`: Son 5 satır görüntülendi
- `describe()`: İstatistiksel özet (ortalama, std, min, max vb.)

### 3️⃣ Sütun Seçimi
- Date, City, Temperature sütunları seçildi
- City ve Temperature kombinasyonu gösterildi

### 4️⃣ Basit Filtreleme
- Sıcaklık > 30°C: **14 kayıt bulundu**
- Bursa şehri: **18 kayıt bulundu**

### 5️⃣ Mantıksal Operatörler ile Filtreleme
- İstanbul VE Nem > 60: **9 kayıt**
- Ankara VEYA Sıcaklık < 5: **28 kayıt**
- Sıcaklık < 10 VEYA Nem > 70: **45 kayıt**

### 6️⃣ Sıralama
- En yüksek sıcaklıktan azalan sıra
- En yüksek nemden azalan sıra
- Şehir ismindne artan alfabetik sıra

### 7️⃣ Yeni Sütun Ekleme
- **Temperature_F**: Fahrenheit cinsinden sıcaklık
  - Formül: `(Temperature * 9/5) + 32`
  
- **FeelsLike**: Hissedilen sıcaklık
  - Formül: `Temperature - (Humidity / 100)`

### 8️⃣ Gruplama ve Analiz

**Şehir Başına Kayıt Sayısı:**
| Şehir | Kayıt Sayısı |
|-------|------------|
| Ankara | 18 |
| Antalya | 11 |
| Bursa | 18 |
| İstanbul | 28 |
| İzmir | 25 |

**Şehir Başına Ortalama Sıcaklık:**
| Şehir | Ortalama Sıcaklık |
|-------|----------------|
| Antalya | 11.71°C |
| Ankara | 14.58°C |
| İzmir | 14.87°C |
| Bursa | 16.74°C |
| İstanbul | 13.63°C |

### 9️⃣ En Yüksek/Düşük Değer Analizi

**En Yüksek Sıcaklık:**
- Sıcaklık: **34.80°C**
- Tarih: 2023-02-01
- Şehir: Ankara

**En Düşük Nem:**
- Nem: **30.04%**
- Tarih: 2023-03-18
- Şehir: İzmir

### 🔟 Dışa Aktarma
- Şehir sıcaklık özeti `sehir_sicakliklari.xlsx` olarak kaydedildi
- Kapsamlar:
  - Ortalama Sıcaklık
  - Maksimum Sıcaklık
  - Minimum Sıcaklık
  - Kayıt Sayısı

## Notebook'u Çalıştırma

1. VS Code'da `weather_analysis.ipynb` dosyasını açın
2. Jupyter Notebook yüklü olmalı
3. Her hücreyi sırasıyla çalıştırın (Ctrl+Enter)
4. Kod ve çıktılarını birlikte göreceksiniz

## Gerekli Kütüphaneler

```python
pandas          # Veri analizi
numpy           # Sayısal hesaplamalar
openpyxl        # isteğe bağlı
```

Kurulum
```bash
pip install pandas numpy openpyxl
```

