# ARADA güncel durum

Son güncelleme: 10 Eylül 2026

## Şu anda çalışan teslim

- XcodeGen ile üretilen native SwiftUI iOS projesi.
- Family Controls bireysel izin isteği.
- Sistem uygulama seçicisi ve seçimin App Group içinde yerel saklanması.
- Seçilen uygulamalara hemen shield uygulayan 15 dakikalık teknik koruma.
- Tekil uygulama, tüm kategori ve web alanı seçimlerini ayrı ayrı özetleyen ve shield'a uygulayan seçim modeli.
- Aktif koruma boyunca kilit ekranı/Bildirim Merkezi'nde geri sayım gösteren Live Activity uzantısı.
- Süre sonunda korumayı kaldırmak için Device Activity Monitor extension.
- ARADA dilinde sınırlı Shield Configuration extension.
- Kullanıcının ARADA içinden korumayı erken bitirmesi.
- Uygulama yeniden aktif olduğunda izin ve süre durumunu uzlaştırma.
- ARADA'nın “dürtü ile eylem arasındaki boşluk” fikrini iki organik durak formuyla anlatan, sıcak kâğıt ve zeytin tonlarında 1024×1024 uygulama ikonu.

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
- Kullanıcı ilk cihaz denemesinde tekil uygulama seçiminin sayıldığını ve temel uygulamanın çalıştığını doğruladı.
- İlk cihaz denemesinde tüm “Sosyal” kategorisinin `0` görünmesi teşhis edildi: seçim kategori tokenı üretiyor, önceki kod yalnız uygulama tokenlarını sayıyor ve koruyordu. Kod kategori ve web alanı tokenlarını da işleyecek şekilde düzeltildi; yeni cihaz derlemesinde tekrar test bekliyor.
- İlk sürümde Live Activity uzantısı bulunmadığı için Bildirim Merkezi'nde sayaç oluşmadı. ActivityKit/WidgetKit uzantısı eklendi; yeni cihaz derlemesinde tekrar test bekliyor.
- Kategori düzeltmesi ve Live Activity içeren dört hedefli proje imzalı olarak derlendi, bağlı “Yeet’s iPhone” cihazına kuruldu ve başlatıldı. Kategori shield'ı ile Live Activity'nin görsel cihaz doğrulaması kullanıcıdan bekleniyor.
- Yeni uygulama ikonu asset catalog'a bağlandı; imzasız ve imzalı iPhoneOS derlemeleri başarılı oldu ve ikonlu sürüm bağlı “Yeet’s iPhone” cihazına kuruldu. Ana ekrandaki küçük boyut görünümü kullanıcı tarafından değerlendirilecek.

## Henüz doğrulanmayanlar

- İzin reddetme davranışı.
- Yeni sürümde tüm kategori seçiminin özette görünmesi ve kategori uygulamalarının shield alması.
- Yeni sürümde Live Activity'nin başlaması, geri sayması ve koruma bitince kalkması.
- Shield'ın seçilen uygulamada görünmesi.
- Telefon kilitliyken veya ARADA kapalıyken yaklaşık 15 dakika sonunda shield'ın kalkması.
- Üç tekrar, erken bitirme ve izin iptali senaryoları.

## Sıradaki iş

Yeni cihaz derlemesini iPhone'a kur. `docs/05-CIHAZ-TESTI.md` içindeki Test A2 ile tüm “Sosyal” kategori seçiminin özette `1 kategori` göründüğünü ve kategori içindeki bir uygulamanın shield aldığını doğrula. Ardından Test B ile Live Activity geri sayımını ve otomatik bitişi doğrula; sonra Test C–D uygulanacak. Bu teknik çekirdek doğrulanınca nihai tasarım sistemi ve ürün akışı ele alınacak.

Gerçek cihaz sonucu kaydedilirken tarih/saat, iOS sürümü, seçilen test uygulaması, koruma başlangıcı, beklenen bitiş, gerçek bitiş ve gözlenen hata yazılmalı. Kişisel uygulama kullanım içeriği kaydedilmemeli.

## Sonraki ürün adımı

Cihaz testi geçince, seçilen dikkat dağıtıcı uygulama açıldığında görülen ARADA müdahalesinin deneyimini tasarla: kısa bekleme, isteğe bağlı niyet, devam veya geri dönme. Apple Shield Action sınırları gerçek SDK ve cihaz davranışına göre ele alınacak. Manuel “Ara ver” yardımcı akış olarak kalacak.
