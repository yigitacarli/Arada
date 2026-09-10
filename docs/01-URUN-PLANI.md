# ARADA ürün planı

## 1. Ürünün iddiası

ARADA, otomatik telefon kullanımını fark etmeyi ve ekranın ardından yapılacak küçük bir gerçek hayat eylemine başlamayı kolaylaştırır.

İlk hedef kitle: Telefonuna sık ve niyetsiz dönen, okumaya veya çalışmaya başlamada zorlanan, yemek ve yolculuk gibi araları sürekli içerikle dolduran yetişkinler. Önce kurucunun günlük kullanımında değer üretilecek, ardından benzer ihtiyacı olan küçük bir grupla sınanacak. Milyonlarca kullanıcı bir vizyon; henüz doğrulanmış talep veya etki değildir.

Ana hipotez: **Seçilen dikkat dağıtıcıları geçici olarak sınırlandırmak + yapılabilir bir başlangıç önermek, yalnızca süre gösteren bir araçtan daha yararlı olabilir.** ARADA özelinde henüz test edilmedi.

Başarı kullanıcının uygulamada daha uzun kalmasıyla ölçülmez. Kullanıcı seçtiği işi daha kolay başlatabilmeli; gerektiğinde ARADA olmadan da yapabilmeli.

## 2. İlk sürümün kullanım döngüsü

1. Ana ekran: “Şimdi neye yer açalım?” Kullanıcının son seçimi birincil öneridir; tahmin motoru gerekmez.
2. Kullanıcı tek bir pratik seçer ve kısa yönergeyi okur.
3. İsterse önceden belirlediği dikkat dağıtıcı uygulamalar için koruma açar.
4. Telefonu bırakır; ekran açık kalmak zorunda değildir.
5. Dönüşte isteğe bağlı tek soru: “Başlayabildin mi?” Yanıt: Evet / Biraz / Bugün olmadı / Atla.
6. Sonuç kısa biçimde kaydolur. Yeni bir içerik akışı açılmaz.

Pratik süresi ile koruma süresi ayrı kavramlardır. Örneğin kitap için 2 dakikalık bir başlangıç önerilirken kullanıcı 15 dakikalık koruma seçebilir. Arayüz ikisini açıkça adlandırır. 2 dakika dolunca uygulamaların otomatik açılacağı sözü verilmez.

## 3. Özellik öncelikleri

| Alan | İlk sürümde davranış | Ölçüm ve sınır |
|---|---|---|
| Derse / kitaba başlama | “Kitabı aç, bir paragraf oku.” 2 veya 5 dakikalık küçük başlangıç; isteğe bağlı 15/25 dakika koruma | Zamanın geçmesi öğrenme veya okuma kanıtı değildir; kullanıcı dönüşü ayrı kaydedilir |
| Ekransız yemek | “İlk birkaç lokmayı ekran olmadan dene.” Süre ve kapsam kullanıcı tarafından seçilir | Yemek yediği kamera veya sensörle denetlenmez |
| Yolculukta ara | “İki dakika çevrene bak.” Süreli pratik; harita, bilet, iletişim açık kalır | Konum izleme ve durak sayma yok; kulaklık çıkarmak zorunlu değil |
| Doomscrolling | Kullanıcının seçtiği uygulamalar için başlatılabilen koruma; engel ekranından kendi niyetini hatırlama | Her uygulama açılışını sınırsız dinleme varsayılmaz; otomatik açılış müdahalesi sonraki araştırma |
| Önce ben | AI'a sormadan önce “Benim ilk tahminim…” düşünme önerisi; yazmak isteğe bağlı, kâğıt da kullanılabilir | AI uygulamasına yazılan sorular okunmaz; doğruluk puanı yok; V0.2'de küçük deney |

V0.1: Aynı oturum motorunu kullanan üç pratik — Başla, Yemek, Yol — ve seçilebilir uygulama koruması, yerel geçmiş, izin durumları.

V0.2: “Önce ben”, kullanıcının istediği zaman dilimlerinde tekrarlanan koruma, yararlı bulunursa widget. Bunlar kişisel testten sonra.

Kapsam dışında: AI koçu/sohbeti, sosyal akış, arkadaş ligi, puan ekonomisi, sonsuz meditasyon kütüphanesi, ses/video içerik üretimi, otomatik psikolojik teşhis, Android ve masaüstü istemcileri, hesap/sunucu, abonelik altyapısı.

## 4. Davranış ve dil

- Kullanıcı süreyi azaltabilir. Zorunlu 8 haftalık program veya her gün yükselen zorluk yok. Teklif edilen küçük süreler ürün hipotezidir; klinik protokol değildir.
- Bir gün atlanınca geçmiş silinmez; seri bozulması, ölen maskot veya kırmızı başarısızlık ekranı yok.
- “İradeni güçlendir”, “dopaminini sıfırla”, “beynini tamir et” gibi iddialar kullanılmaz.
- “Bugün olmadı. Daha kısa bir ara seçebilirsin.” gibi sakin ve somut metinler kullanılır.
- Normal kullanım için telefonun ekranını açık tutma veya yüzüstü çevirme zorunluluğu yoktur. Sensör hareketi odaklanma kanıtı sayılmaz.
- Müzik ve kulaklık kullanımı tek başına başarısızlık değildir. Kişinin kendi seçimi esastır.
- ARADA bir tedavi değildir. Gün içinde sık uykuya dalma veya uykululuğun günlük yaşamı etkilemesi halinde sağlık değerlendirmesi önerilir; tüm belirtiler ekran kullanımına bağlanmaz. [NHS](https://www.nhs.uk/conditions/excessive-daytime-sleepiness-hypersomnia/)

## 5. Ekran kapsamı

**İlk açılış:** Kısa amaç → en zor gelen anı seç → ilk pratiği dene. Hesap, kişilik testi ve erken ödeme duvarı yok. Screen Time izni, kullanıcı ilk kez koruma istediğinde gerekçesiyle sorulur.

**Bugün:** Tek öneri, bir başlat eylemi, diğer iki pratiğe kısa erişim. Üstte ayarlar. Büyük istatistik panosu yok.

**Hazırlık:** Bir cümlelik yönerge, başlangıç süresi ve varsa koruma süresi, seçilmiş uygulama sayısı. Koruma izni yoksa açıkça “Korumasız pratik”.

**Ara:** Pratiğin adı ve “Telefonu bırakabilirsin.” Süreyi görmek isteğe bağlıdır. Sistem kilidi kullanılabilir; sahte kilit ekranı yok.

**Dönüş:** Tek isteğe bağlı soru ve kapat. Koruma sürüyorsa ayrı görünür; kullanıcı sessizce kilitli bırakılmaz.

**Geçmiş:** Günlere göre pratikler ve isteğe bağlı yanıtlar. Boş durum gerçeği gösterir. Süre, özbildirim ve varsa sistem ekran süresi birbirinin yerine kullanılmaz.

**Ayarlar:** Korunan uygulamalar, izin durumu, bildirim tercihi, erişilebilirlik, tüm yerel verileri sil.

## 6. Kişisel doğrulama ve büyüme

İlk 3 gün: Mevcut alışkanlığın basit gözlemi; ekranda geçirilen süreyi sağlık puanına dönüştürmeden, hangi anda zorlanıldığı not edilir. Sonraki 7–14 gün: ARADA ile bir veya iki seçilmiş durumda deneme. Yoğun sınav haftası, uyku ve çalışma koşulları gibi değişimler not edilir; önce/sonra farkı tek başına nedensellik göstermez.

Ana ölçüt: “Seçtiğim gerçek hayat işine başlayabildiğim günler / denemeyi planladığım günler.” Bu özbildirimdir. Yanıt verilmemiş oturumlar başarı sayılmaz ve yanıt oranı ayrıca tutulur.

Destekleyici ölçütler: koruma hataları, erken çıkışlar, kurulumda takılma, uygulamayı kullanmanın yarattığı yük. Oturum süresine “geri kazanılmış hayat” adı verilmez.

Önerilen ürün kapısı: 14 günde kullanıcı en az 8 gün kendi isteğiyle kullanmış, en az bir gerçek hayat durumunda somut yarar anlatmış ve kritik engelleme/kaldırma hatası yaşamamışsa kapalı teste geç. Bunlar ekip karar eşikleridir, bilimsel başarı kriteri değildir.

Kapalı test: 10–20 yetişkin, yaklaşık iki hafta. En az 5 kısa görüşme; “Son kullandığın anda ne oldu?”, “Nerede kapatmak istedin?”, “Yarın kullanmazsan neyi özlersin?” Aynı sorun tekrarlanırsa kapsam büyütmek yerine o sürtünme düzeltilir.

Büyüme sırası: kişisel yarar → küçük TestFlight grubu → 50–100 kişiyle güvenilirlik → Türkçe mağaza açılışı → İngilizce ve daha geniş dağıtım → doğrulanan talebe göre Android. Takvimden önce aşama kapıları önemlidir.

## 7. Gelir ve ölçek

Kişisel sürüm ve kapalı test ücretsiz. Talep kanıtlandığında ücretsiz temel pratikler; ücretli gelişmiş zamanlama/kişiselleştirme ihtimali görüşmelerle sınanır. Şimdiden fiyat veya ömür boyu destek sözü verilmez. Reklam ve kişisel kullanım verisi satışı önerilmez.

Cihazda çalışan çekirdek, kullanıcı başına AI/API maliyetini gerektirmez. Büyük ölçekte asıl işler mağaza dağıtımı, iOS uyumluluğu, destek ve yerelleştirmedir. Bulut yalnızca kullanıcıların doğrulanmış bir senkronizasyon ihtiyacı olduğunda eklenir.
