# Teknik yol haritası

## Mimari kararı

Öneri: Swift + SwiftUI, ilk hedef iPhone 16e. Web arayüzü yalnızca tasarım incelemesi veya gelecekte tanıtım için; iOS engellemesini web/PWA çözümü olarak vaat etme. React Native/Flutter ortaklığına ilk sürümde ihtiyaç yok.

Önerilen katmanlar: Features (ekranlar), Domain (oturum ve pratik kuralları), Persistence (yerel kayıt), ScreenTime (izin/seçim/koruma), Design (renk/yazı/bileşenler). Modüller için ayrı paket veya karmaşık altyapı zorunlu değil.

Apple çerçeveleri: FamilyControls ile bireysel yetkilendirme ve seçim; ManagedSettings ile koruma; DeviceActivity ile desteklenen zamanlama. Gerekli uzantılar: DeviceActivityMonitor, ShieldConfiguration; ShieldAction ancak doğrulanmış etkileşim için. DeviceActivityReport ilk MVP'de gerekli değil.

Yerel veri: Ayarlarda UserDefaults; oturum geçmişi için sürümlü Codable JSON ve atomik yazım yeterli ilk aday. App Group alanında uzantıların ihtiyaç duyduğu minimum aktif koruma kaydı. Kullanıcı yazılı notları uzantılara taşınmaz. App/extension eşzamanlı yazımı tek sahipli dosyalar veya açık koordinasyonla çöz; tek JSON dosyasına kontrolsüz ortak yazma yapma.

Şema: Practice(id, suggestedSeconds), Session(id, practiceID, intention?, startedAt, plannedPracticeSeconds, endedAt?, outcome?), Protection(id, sessionID?, scheduledEndAt, status), Settings(schemaVersion, preferences). Sistem uygulama seçimi opak token olarak tutulur; isim/bundleID çıkarma varsayımı yapılmaz.

Durumlar ayrı: Pratik idle/running/finished/endedEarly; koruma off/starting/active/stopping/failed/unknown. Koruma başarısızken UI “aktif” göstermemeli. Uygulama öldürülünce kullanıcı odaklanmış veya başarısız sayılmaz. Sonraki açılışta zaman ve koruma durumu uzlaştırılır; belirsizlik saklanmaz.

## En önemli teknik sınırlar

1. Apple Developer üyeliği, her target için Family Controls dağıtım yetkisi olduğu anlamına gelmez. Eski repodaki CLAUDE.md, 10 Eylül'de onay alındığını iddia ediyordu; bu yalnızca eski repo notudur. Portal/App ID ve provisioning üzerinden doğrulanmalı; mevcut yetki varsa gereksiz yeni başvuru yapılmamalı. Uygulama ve kullanılan uzantılar ayrı değerlendirilir. [Apple](https://developer.apple.com/documentation/familycontrols/requesting-the-family-controls-entitlement)
2. Bireysel yetkilendirmede kullanıcı izni geri çekebilir; uygulamayı kaldırmayı engelleyen ebeveyn denetimi güvenceleri varsayılmaz. “Aşılamaz kilit” sözü yok. [Apple WWDC22](https://developer.apple.com/videos/play/wwdc2022/110336/)
3. Shield ekranı serbest bir SwiftUI ekranı değildir. Desteklenen metin/görsel/düğme düzeniyle sınırlıdır. Engel ekranından her koşulda ARADA'yı açmak veya 10 saniyelik animasyon göstermek tasarım önkoşulu olamaz. [ShieldConfiguration](https://developer.apple.com/documentation/managedsettingsui/shieldconfiguration)
4. iOS arka planında genel amaçlı saniyelik timer güvenilir engel kaldırma mekanizması değildir. Kısa pratik ile OS koruma zamanlamasını ayır. DeviceActivity'nin süre sınırlarını mevcut SDK ve cihazda doğrula. İlk teknik deney 15 dakikalık desteklenen zamanlama üzerinde yapılacak; 2 dakikalık pratik için 2 dakikada otomatik kilit açma vaat edilmeyecek. [DeviceActivitySchedule](https://developer.apple.com/documentation/deviceactivity/deviceactivityschedule)
5. Sistem kullanım raporlarına sınırsız ham veri erişimi varsayma. Toplam ekran süresi ölçümü ilk sürümün kritik yolundan çıkarılmıştır. Oturum süresi “odak süresi” diye doğrulanmış veri sunulamaz.
6. Koruma listesi kullanıcı seçimiyle dar tutulur. ARADA, telefon, harita, bilet ve ihtiyaç duyulan iletişim engellenmemeli. MVP'de tüm kategori yerine tek tek uygulama seçimi tercih edilir. Kullanıcı ARADA'dan açıkça korumayı bitirebilir.

## Aşamalar

Süreler odaklı geliştirme günü tahminidir; AI çalışma süresi veya teslim garantisi değildir. Apple incelemesi, cihaz erişimi ve revizyonlar ayrıca süre ekleyebilir. Teknik çalışma ile tasarım araştırması farklı günlerde ilerleyebilir; uygulama motoru doğrulanmadan tam ekran seti kodlanmaz.

| Aşama | Yaklaşık efor | Somut teslim ve geçiş kapısı |
|---|---|---|
| 0 — Hesap ve cihaz hazırlığı | 0.5–1 gün | Xcode/SDK ve gerçek iOS sürümü kaydı; Bundle ID ve app/extension yetki durumu; kişisel veri içermeyen kurulum notu |
| 1 — Engelleme deneyi | 2–4 gün | Gerçek cihazda seçim → 15 dk koruma → kilitli ekranda otomatik kaldırma; erken çıkış ve izin iptali gözlemi |
| 2 — Tasarım kararı | 2–3 gün | İki Bugün alternatifi, seçilen yönde 5 temel ekran ve hata durumları; cihaz boyutunda kullanıcı değerlendirmesi |
| 3 — Kişisel V0.1 | 5–8 gün | Tek Ara ver akışı; isteğe bağlı niyet; tek oturum motoru; yerel geçmiş; koruma ve pratik ayrımı; hesapsız/offline kullanım |
| 4 — Kişisel deneme | 7–14 takvim günü | Kullanıcının somut geri bildirimi, hata kaydı ve öncelikli en çok 3 düzeltme |
| 5 — Kapalı beta | 3–5 gün hazırlık + yaklaşık 14 gün test | TestFlight build'i, izin kurulumu, 10–20 kişi testi, kritik hata düzeltmeleri |
| 6 — İlk mağaza sürümü | Beta sonucuna bağlı | Gerçek ekran görüntüleri, gizlilik beyanları, destek kanalı, erişilebilirlik ve sürüm kontrolü |

Başarısız kapı: Otomatik koruma kaldırma güvenilir değilse yayınlama. Önce aynı teknik deneyi düzelt; yeni özellik, AI sağlayıcısı veya tasarım yenilemesiyle sorunu örtme. Gerekirse açıkça korumasız pratik prototipiyle davranış testine devam et; bunu engelleyen uygulama olarak tanıtma.

## Küçük görevler

| ID | Bağımlılık | İş | Tamamlanma ölçütü |
|---|---|---|---|
| T00 | Yok | Xcode, SDK, imza, target izinlerini incele | Doğrulanan/bekleyen ayrımıyla kısa rapor |
| T01 | T00 | Minimum native proje ve izin/seçim akışı | Cihazda ret, izin ve yeniden açma çalışır; seçilen tokenlar korunur |
| T02 | T01 | 15 dakikalık koruma ve kaldırma deneyi | En az üç fiziksel cihaz denemesinde başlangıç/bitiş saatleri ve sonuç kaydedilir; tolerans gözlenir, sıfır gecikme iddiası yok |
| T03 | T02 | Erken bitirme ve izin kaybı toparlanması | Koruma tek işlemle kaldırılır; kayıp izinde aktif etiketi kalmaz |
| T04 | Yok | İki tasarım yönü, birini seçme | Kullanıcı tek yönü değerlendirir; karar gerekçesi ve ekran durumları kayıtlı |
| T05 | T03,T04 | Pratik motoru ve isteğe bağlı niyet | Niyet seçmeden başlanabilir; dinlenme ve düşünme iş tamamlama sayılmaz; kısa pratiğin bitmesi koruma bitmiş gibi gösterilmez |
| T06 | T05 | Yerel geçmiş ve yanıt | Yeniden açmada kayıt kalır; cevapsız veri başarı sayılmaz; çift callback çift kayıt üretmez |
| T07 | T06 | Erişilebilirlik ve hata durumları | Büyük yazı, VoiceOver, koyu tema, offline ve boş geçmiş çalışır |
| T08 | T07 | 7–14 günlük kişisel test | Bulgularla devam/düzelt kararı, en çok üç sorun |
| T09 | T08 | İsteğe bağlı düşünce notu deneyi | Ortak akışa yerel not eklenmesinin katkısı denenir; yazmadan devam mümkün, dış AI soruları okunmaz |
| T10 | T08 | TestFlight hazırlığı | Dağıtım target izinleri doğrulanmış; cihaz üstü beta kurulumu başarılı |

## Kritik test senaryoları

- Ekran kilitli, uygulama arka planda ve zorla kapalıyken planlanan koruma bitişi.
- Yeniden başlatma sonrası toparlanma; airplane mode; düşük güç; saat dilimi/saat değişimi.
- İzin reddi/iptali, boş uygulama seçimi, korumayı kurarken hata ve tekrarlanan callback.
- Art arda başlat tuşuna basma: aynı anda iki koruma yaratılmamalı.
- 2 dakikalık pratik biterken 15 dakikalık korumanın devam etmesinin doğru anlatılması.
- Kullanıcı korumayı erken bitirir: seçilen uygulamalar açılır; geçmiş uydurma başarı üretmez.
- Telefon/harita/bilet erişimi; büyük metinde eylemlere ulaşma; cihaz verilerini silme.

İçerik kabulü: Niyet seçmeden başlangıç, sadece dinlenme, kendi başına düşünme ve kullanıcının seçtiği farklı etkinliklerde aynı akış denenir. Öğrenci/meslek/etkinlik varsayımı veya zorunlu yazılı cevap bulunmamalı.

Saf birim testleri oturum geçişleri, zaman uzlaştırma, çift kayıt ve veri göçü gibi mantık için. Screen Time davranışı fiziksel cihazda doğrulanmadan “testler geçti” ifadesi ürün kanıtı değildir. Simülatör görsel test içindir.

## Teslim disiplini

Her görevde derleme/test komutu, yapılan cihaz testi ve yapılmayan kısım belirtilir. Apple hesabındaki işlemler kullanıcı arayüzü/izin gerektirebilir; ajanın göremediği portal durumu tahmin edilmez. İlk geliştirme turunda Xcode projesi üretim yöntemi bir kez seçilir ve temiz checkout'tan kurulumu belgelenir. Signing anahtarları, kişisel günlükler ve sertifikalar Git'e konmaz.
