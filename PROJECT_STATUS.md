# ARADA güncel durum

Son güncelleme: 10 Eylül 2026

## Şu anda çalışan teslim

- XcodeGen ile üretilen native SwiftUI iOS projesi.
- Family Controls bireysel izin isteği.
- Sistem uygulama seçicisi ve seçimin App Group içinde yerel saklanması.
- Seçilen uygulamalara hemen shield uygulayan 15 dakikalık teknik koruma.
- Süre sonunda korumayı kaldırmak için Device Activity Monitor extension.
- ARADA dilinde sınırlı Shield Configuration extension.
- Kullanıcının ARADA içinden korumayı erken bitirmesi.
- Uygulama yeniden aktif olduğunda izin ve süre durumunu uzlaştırma.

Bu ekran teknik denemedir; nihai ürün tasarımı değildir. Uygulama açılışlarında sürekli müdahale, yeniden müdahale, niyet akışı, geçmiş ve manuel ara oturumu henüz yoktur.

## Doğrulananlar

- Mac: macOS 15.7.9.
- Xcode 26.3, iOS SDK 26.2, Swift 6.2.4.
- `xcodegen generate` başarılı.
- İmza kapalı generic iPhoneOS derlemesi başarılı; ana uygulama ve iki uzantı birlikte derlendi.
- İmza kapalı generic iPhoneOS `build-for-testing` başarılı; test bundle derlendi. Testler fiziksel cihaz veya çalışan simülatör olmadığı için yürütülmedi.
- Xcode otomatik provisioning ile `app.arada.ios` ve iki extension için güncel geliştirme profillerini oluşturdu; App Group ve Family Controls yetkileriyle imzalı cihaz derlemesi başarılı.
- İmzalı uygulama bağlı “Yeet’s iPhone” cihazına kuruldu ve `app.arada.ios` başarıyla başlatıldı. Cihaz iOS 26.6.1 olarak görüldü.
- Kullanıcı Apple Developer üyeliği ve Family Controls dağıtım izni olduğunu açıkça doğruladı.

## Henüz doğrulanmayanlar

- Uygulama seçicinin gerçek cihazda izin verme/reddetme davranışı.
- Shield'ın seçilen uygulamada görünmesi.
- Telefon kilitliyken veya ARADA kapalıyken yaklaşık 15 dakika sonunda shield'ın kalkması.
- Üç tekrar, erken bitirme ve izin iptali senaryoları.

## Sıradaki iş

Telefonda açık olan ARADA'da `docs/05-CIHAZ-TESTI.md` içindeki Test A'yı tamamla: Screen Time izni ver, zararsız bir test uygulaması seç, seçilen sayının 1 olduğunu ve yeniden açınca seçimin korunduğunu doğrula. Ardından Test B–D uygulanacak. Test başarıyla geçmeden tasarım sistemini ve ürün akışını genişletme.

Gerçek cihaz sonucu kaydedilirken tarih/saat, iOS sürümü, seçilen test uygulaması, koruma başlangıcı, beklenen bitiş, gerçek bitiş ve gözlenen hata yazılmalı. Kişisel uygulama kullanım içeriği kaydedilmemeli.

## Sonraki ürün adımı

Cihaz testi geçince, seçilen dikkat dağıtıcı uygulama açıldığında görülen ARADA müdahalesinin deneyimini tasarla: kısa bekleme, isteğe bağlı niyet, devam veya geri dönme. Apple Shield Action sınırları gerçek SDK ve cihaz davranışına göre ele alınacak. Manuel “Ara ver” yardımcı akış olarak kalacak.
