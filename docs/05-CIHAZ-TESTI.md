# İlk iPhone 16e cihaz testi

Bu test Screen Time çekirdeğini doğrular. Görsel tasarım değerlendirmesi değildir.

## Bir kez yapılacak hazırlık

1. Mac'te Terminal'i aç ve repo klasöründe `xcodegen generate` çalıştır.
2. `Arada.xcodeproj` dosyasını Xcode ile aç.
3. iPhone'u Mac'e bağla; telefonda bu bilgisayara güven ve gerekirse Developer Mode'u etkinleştir.
4. Xcode üst çubuğundan hedef cihaz olarak iPhone 16e'yi seç.
5. Ana uygulama ile iki extension target'ın Signing & Capabilities bölümünde aynı Team'i seç.
6. Ana uygulama ve Device Activity Monitor için `group.app.arada.shared` App Group'unun etkin olduğunu doğrula.
7. Family Controls capability'nin ana uygulama ve iki extension App ID/profilinde bulunduğunu doğrula. Xcode otomatik imza hatası verirse hata metnini aynen kaydet; rastgele bundle ID veya entitlement silme.

## Test A — izin ve seçim

1. Uygulamayı iPhone'da çalıştır.
2. “Screen Time izni ver” düğmesine bas ve izin ver.
3. “Uygulamaları seç” ile yalnızca zararsız bir test uygulaması seç. Telefon, harita, bilet veya gerekli iletişim uygulaması seçme.
4. Seçimden dönünce sayının `1` olduğunu doğrula.
5. ARADA'yı tamamen kapatıp yeniden aç; seçimin korunduğunu doğrula.

## Test B — koruma ve otomatik bitiş

1. Başlangıç saatini kaydet ve “15 dakikalık ara başlat” düğmesine bas.
2. Seçilen test uygulamasını aç; ARADA shield ekranını gördüğünü doğrula.
3. Telefonu kilitle ve ARADA'yı açık tutma.
4. Beklenen bitişten sonra test uygulamasını yeniden aç.
5. Shield kalktıysa gerçek bitiş saatini kaydet. Birkaç dakikalık gecikme varsa süreyi de yaz; tam zamanında çalışmış gibi raporlama.

## Test C — erken bitirme

1. Yeni koruma başlat.
2. Seçilen uygulamada shield'ı doğrula.
3. ARADA'ya dönüp “Korumayı bitir” düğmesine bas.
4. Seçilen uygulamanın hemen açıldığını doğrula.

## Test D — izin iptali

1. Koruma açıkken iOS Ayarlar içinden ARADA'nın Screen Time erişimini kapat.
2. ARADA'ya dön.
3. Uygulamanın aktif koruma iddiasını kaldırdığını ve açık bir hata gösterdiğini doğrula.

Test B'yi üç kez yapmadan otomatik kaldırma güvenilir sayılmaz. Sonuçları `PROJECT_STATUS.md` dosyasına ekle veya hata ekranını/mesajını yeni sohbette paylaş; yeni sohbet önce bu dosyayı okuyacak.
