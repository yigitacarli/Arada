# Arada

Sıkılabilme kapasitesini antrenmanla geri kazandıran bir iOS uygulaması.
Bu dosya, projeye yeni katılan bir Claude oturumunun bilmesi gereken her şeyi taşır.

**Kullanıcıyla Türkçe konuş.**

---

## Kullanıcı

Yiğit. Kod yazmıyor ve buna vakti yok — **kodun tamamını Claude yazıyor.** Onun rolü
ürün kararları, cihazda test ve hesap/mağaza işlemleri. Ona düşen işi minimumda tut,
her adımı tek tek ve yapıştırılabilir hâlde ver. Uzun kurulum talimatı yerine çalışan çıktı üret.

Donanım: Windows 11 masaüstü (günlük çalışma burada), MacBook Air M2 (var, ama üstünde
çalışmayı sevmiyor — sadece Xcode gerektiğinde), iPhone 16e.

- Apple Team ID: `U2KFX3D9XQ` (`Config/Signing.xcconfig` içinde)
- **Family Controls (Distribution) yetkisi 10 Eylül 2026'da onaylandı.** Beklenen haftalarca
  gecikme olmadı; Screen Time entegrasyonunun önünde engel yok.

## Ürün

Doomscrolling, sıkılma toleransının körelmesi ve **yapay zekâya düşünmeyi devretme**
sorununa karşı. Üçüncüsü pazarda tamamen boş ve asıl farkımız orada.

Üç sütun:

1. **Sıkılma Antrenmanı** — 8 haftalık kademeli program, 2 dakikadan 22 dakikaya.
   Şu an kodda olan tek şey bu.
2. **Geçiş Anları** — yemek / yol / bekleme / yatak modları, Screen Time ile engelleme.
3. **Kendi Kafanla** — yapay zekâya sormadan önce kendi denemeni yazdıran modül.

Kararlar (sabit, yeniden tartışma):

- iOS önce, **native SwiftUI**. Android 2027 Q1. Web sadece pazarlama.
- Türkçe + İngilizce, ilk günden.
- **Genel gençlik kitlesi — sınav odaklı değil.** (Kullanıcı YKS'yi sadece örnek verdi.)
- Ekran süresi rakamı asla gösterilmez. Dört "yukarı giden" metrik kullanılır.
- Freemium + $79 ömür boyu. Para modeli 2027 Q1'e ertelendi — ücretsiz uygulama için
  hiçbir vergi evrakı gerekmiyor, bu bilinçli bir sadeleştirme.
- "Mola" ismi App Store'da aynı kategoride alınmış, kullanılamaz.

## Görsel sistem — pazarlık konusu değil

Yön: **rengini dışarıdan alan uygulama + elle çizilmiş marka.**
Apple Design Awards 2026'daki Tide Guide / Moonlitt ailesi.

- Zemin beyaz ya da siyah değil — **sıvalı bir duvar** (`#CBC4B7`), gerçek dokulu.
- **Vurgu rengi yok.** Pencereden düşen ışığın kendisi vurgu.
- Palet günün saatine göre kayar: sabah soğuk, öğleden sonra sıcak, gece ay ışığı.
- Marka işareti bir pencere: kare çerçeve, içinde aydınlıkla gölgenin yumuşak kenarı.
- Tipografi iki yüz: **Instrument Serif** (rakamlar + logotype), **Newsreader** (metin).
- Mürekkep `#221E17`, ara tonlar `#5A5245` / `#A79D8B`.

Oturum mekaniği — **geri sayım rakamı yok.** Telefon yüzüstü çevrilince ışık pencereden
girer ve karşı kenara yürür. 2 dakikada da 22 dakikada da aynı mesafeyi kat eder, yani
süre uzadıkça yavaşlar. "Ne kadar kaldı" kaygısını ortadan kaldırmak kasıtlı.

Yasaklar: sohbet balonu, gradyan süsü, rozet, emoji, seri bozulma paniği, sonsuz akış,
aciliyet bildirimi, maskot. Uygulamanın kendisi günde 3 dakikadan fazla kullanılmamalı —
oturumlar hariç. Bir özellik önerirken "bu, uygulamada geçirilen süreyi artırır mı" diye
sor; artırıyorsa önerme.

Kullanıcı tasarıma çok önem veriyor ve **ilk denemede çıkan wireframe'i haklı olarak
reddetti.** Sadelik ucuzluğun mazereti değil: malzeme, doku, ışık ve karakterli tipografi
olmadan hiçbir ekranı teslim etme.

## Çalışma düzeni

Xcode projesi depoda **tutulmuyor**, `project.yml`'den üretiliyor:

```bash
brew install xcodegen
xcodegen generate
open Arada.xcodeproj
```

İki makine arasında geçiş **Git ile**. Google Drive (`G:`) Xcode projelerini ve git
depolarını bozuyor — `.git` klasörüne `desktop.ini` enjekte ediyor, `.xcodeproj` bir
paket olduğu için yarım senkronize olup çöküyor. Projeyi asla Drive altına koyma.

GitHub: <https://github.com/yigitacarli/Arada> · dal `main`

## Durum

Görsel sistem SwiftUI'a geçirildi ama **hâlâ hiç derlenmedi** — kod Windows'ta
üretildi, Xcode orada yok. İlk `xcodegen generate` + `⌘R`'de hata çıkması olası;
çıkarsa düzelt, sonra cihazda görerek ışık/doku/tipografi ince ayarı yap.

- `Model/Program.swift` — 8 haftalık program, kaçırılan gün kuralı
- `Model/Store.swift` — cihazda JSON, sunucu yok, hesap yok
- `Model/FaceDownMonitor.swift` — CoreMotion, `gravity.z > 0.8`
- `Design/Theme.swift` — `DayLight` (günün saati → palet), fontlar, `RailLabel`
- `Design/Wall.swift` — `WallGradient`, `GrainOverlay` (CoreImage gürültü),
  `BrandMark` (pencere), `StaticBeam` (Bugün), `WalkingLight` (Oturum)
- `Design/Components.swift` — `QuietButton`, `ProgramLadder`, `Hairline`
- `Features/TodayView.swift` — Bugün ekranı, yeni sistem
- `Features/SessionView.swift` — Oturum: bekleme → ışık yürür → bitti
- `Resources/Fonts/` — Instrument Serif + Newsreader (OFL), `project.yml`'de `UIAppFonts`

Bilinen belirsizlikler (Xcode'da doğrulanacak):
- Newsreader değişken font; `.weight(.light)` düşmezse statik kesit gerekir (Fonts/README.md).
- `WalkingLight` ışık dörtgeni ve blur değerleri gözle ayarlanmalı — Windows'ta tahminî yazıldı.
- Oturumda `WallGradient(dimmed:)` ekranı %86 karartıyor; cihazda fazla/az olabilir.

Sıradaki iş: derleme hatalarını temizle → cihazda görsel ince ayar → Screen Time entegrasyonu (Faz 2).

## Referanslar

- Ürün planı: <https://claude.ai/code/artifact/2214130a-eb94-4a49-b726-89521662dcef>
- Tasarım stratejileri: <https://claude.ai/code/artifact/e00b2b04-ef9c-4879-9fb6-2f1f4a15914e>
- Ekran tasarımı: <https://claude.ai/code/artifact/f84d68ff-a647-4306-b4ae-3000902e8351>
- Maket kaynak dosyaları: `design/final/*.dc.html`
