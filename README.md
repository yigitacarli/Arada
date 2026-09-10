# Arada

Sıkılabilme kapasitesini antrenmanla geri kazandıran bir iOS uygulaması.

Ürün planı: <https://claude.ai/code/artifact/2214130a-eb94-4a49-b726-89521662dcef>

**Durum:** Faz 1 — Sıkılma Antrenmanı çalışıyor, engelleme henüz yok.

---

## Mac'te ilk kurulum (bir kez, ~5 dakika)

Xcode proje dosyası (`.xcodeproj`) depoda tutulmuyor — `project.yml`'den üretiliyor.
Böylece dosya ekleyip çıkarmak için Xcode arayüzünde tıklamakla uğraşmıyorsun.

```bash
brew install xcodegen
cd ~/Projeler/Arada
xcodegen generate
open Arada.xcodeproj
```

`Config/Signing.xcconfig` dosyasını aç ve Team ID'ni yaz:

```
DEVELOPMENT_TEAM = A1B2C3D4E5
```

Team ID: developer.apple.com → Account → Membership details → Team ID.

Sonra iPhone'u kabloyla bağla, Xcode'un üst çubuğundan cihazı seç, **⌘R**.

## Sonraki her seferde

```bash
cd ~/Projeler/Arada
git pull
xcodegen generate    # sadece yeni dosya eklendiyse gerekir
```

---

## İki makine arasında geçiş

Kod **Git ile** taşınıyor, Google Drive ile değil. Drive `.git` klasörüne `desktop.ini`
enjekte edip depoyu bozuyor ve `.xcodeproj` bir paket olduğu için yarım senkronize
olup çöküyor. Bu bilinen bir sorun, istisnası yok.

Windows'ta:

```bash
git add -A && git commit -m "..." && git push
```

Mac'te:

```bash
git pull
```

---

## Proje yapısı

```
project.yml                 Xcode projesinin tarifi (XcodeGen)
Config/Signing.xcconfig     Team ID — bir kez doldurulur
docs/                       Apple başvuru metni vb.
Arada/
  AradaApp.swift            Giriş noktası
  Design/Theme.swift        Renkler ve tipografi (kâğıt + mürekkep, iki tema)
  Design/Components.swift    Düğme, program ızgarası, ayraç
  Model/Program.swift       Sekiz haftalık program: 2 → 22 dakika
  Model/Store.swift         Cihazda JSON. Sunucu yok, hesap yok.
  Model/FaceDownMonitor.swift  Telefon yüzüstü mü — CoreMotion
  Features/TodayView.swift  Ana ekran
  Features/SessionView.swift   Oturum sayacı
  Resources/{en,tr}.lproj   Metinler
```

## Tasarım kuralları (pazarlık konusu değil)

- Uygulama günde 3 dakikadan fazla kullanılmamalı — oturumlar hariç.
- Sohbet balonu, gradyan, rozet, emoji, seri bozulma paniği yok.
- Ekran süresi rakamı gösterilmez.
- Kaçırılan gün programı sıfırlamaz, bir basamak geri alır.

## Bilinen eksikler

- Oturum sırasında ekran açık kalıyor (`isIdleTimerDisabled`). Faz 2'de `DeviceActivity`
  ile arka plana taşınacak.
- Bitiş uyarısı titreşim + haptik. Telefon yumuşak zemindeyse fark edilmeyebilir;
  Faz 2'de yerel bildirim eklenecek.
- Engelleme, geçiş modları ve "Kendi Kafanla" modülü henüz yok — Faz 2.
