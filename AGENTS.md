# ARADA çalışma talimatı

Bu dosya yeni bir Codex sohbetinin başlangıç noktasıdır. Kullanıcıyla Türkçe konuş.

## Oturum başlangıcı

1. `PROJECT_STATUS.md` dosyasını oku.
2. `git status --short --branch` ve son üç commit'i kontrol et.
3. Yapılacak iş için yalnızca ilgili plan belgesini ve hedef kaynak dosyalarını oku.
4. `PROJECT_STATUS.md` içindeki “Sıradaki iş” tamamlanmadan kapsamı büyütme.

## Kullanıcı ve ürün kararları

- İlk platform iOS; kullanıcı iPhone 16e, MacBook ve Apple Developer üyeliğine sahip.
- Kullanıcı Family Controls dağıtım izninin bulunduğunu doğruladı. Ana uygulama ve iki extension, Family Controls/App Group içeren geliştirme profilleriyle imzalı cihaz derlemesinden geçti. Dağıtım profilleri App Store/TestFlight aşamasında ayrıca doğrulanacak.
- Kitap, yemek ve yol yalnızca kullanıcı örnekleriydi. Bunları kategori veya ana menüye dönüştürme.
- ARADA belirli meslek veya etkinliklere göre ayrılmaz. Ortak sorun, telefonun bazen bilinçli seçim yerine otomatik biçimde kullanılmasıdır.
- Çekirdek ürün anı: Kullanıcı seçtiği dikkat dağıtıcı uygulamayı açtığında otomatik davranışa kısa bir ara koymak; devam etme veya telefonu bırakma kararını kullanıcıya vermek.
- Manuel “Ara ver” oturumu destekleyici olabilir; tek başına ürünün merkezi değildir.
- Dinlenmek, kendi başına düşünmek, biriyle birlikte olmak ve bir şeye yönelmek eşit derecede geçerlidir. Üretkenlik zorunlu değildir.
- Yargı, korku, seri kaybı, ölen maskot, dopamin detoksu veya tedavi iddiası kullanma.
- V0.1 cihazda çalışır; hesap, backend, AI servisi ve ödeme içermez.
- Tasarım kullanıcı için kritiktir. Hazır AI panosu, kart yığını, rastgele mor/mavi gradyan veya genel şablon görünümü üretme. Teknik spike ekranı nihai tasarım değildir.

## Teknik kurallar

- Native Swift + SwiftUI. Proje `project.yml` ile XcodeGen tarafından üretilir; `.xcodeproj` Git'e konmaz.
- Minimum iOS 17. FamilyControls, ManagedSettings ve DeviceActivity kullanılır.
- Kısa kullanıcı arası ile sistem koruma süresini ayrı durumlar olarak modelle. Arka planda güvenilir olmayan saniyelik timer ile engel kaldırma vaat etme.
- Koruma başarısızsa arayüzde aktif gösterme. İzin iptali ve süresi geçmiş durum toparlanmalı.
- Sistemden gelen opaque uygulama tokenlarından isim veya bundle ID çıkarmaya çalışma.
- Family Activity seçimini yalnızca uygulama tokenı sayarak yorumlama. Uygulama, kategori ve web alanı tokenlarını hem seçim özetinde hem shield ayarlarında destekle.
- Aktif 15 dakikalık koruma, ActivityKit Live Activity ile kilit ekranında geri sayım gösterir. Live Activity'nin sistem ayarından kapalı olması korumanın başlamasını engellemez; arayüz bunu açıkça bildirir.
- Screen Time davranışı yalnızca fiziksel cihaz testiyle doğrulanmış sayılır. Simülatör veya imzasız derleme ürün kanıtı değildir.
- Sertifika, provisioning profili, kişisel günlük veya gizli veri commit etme.
- Her anlamlı görev sonunda `PROJECT_STATUS.md` dosyasını gerçek durumla güncelle. Yapılmayan testi yapılmış gibi yazma.

## Doğrulama

Önce proje üret:

```bash
xcodegen generate
```

İmzasız iPhoneOS derlemesi:

```bash
xcodebuild -project Arada.xcodeproj -scheme Arada -sdk iphoneos \
  -destination 'generic/platform=iOS' CODE_SIGNING_ALLOWED=NO \
  -derivedDataPath /tmp/arada-derived build
```

Kaynak değişikliğinde `git diff --check` çalıştır. Cihaz testi gerekiyorsa `docs/05-CIHAZ-TESTI.md` adımlarını uygula ve sonucu `PROJECT_STATUS.md` içine kaydet.
