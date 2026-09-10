# Sonraki geliştirme oturumuna devir

## Doğrulananlar

- Kullanıcı Türkçe iletişim istiyor; önce kendi kullanımı, sonra geniş kitle için ARADA.
- iPhone 16e, MacBook ve Apple Developer üyeliği var.
- Repo: https://github.com/yigitacarli/Arada, main.
- Kullanıcı tüm eski dosyaların silinmesini açıkça istedi. Temizlik commit'i: ae8aea5. Eski commit: 4edc864.
- İlk SwiftUI teknik çekirdeği yazıldı ve imzasız iPhoneOS derlemesi geçti. Fiziksel cihaz testi yapılmadı; güncel gerçek durum için kökteki `PROJECT_STATUS.md` esas alınır.

## Kullanıcının kapsam düzeltmesi

Kitap, yemek ve yol yalnızca örneklerdi. Bunları kategoriye dönüştüren önceki plan kullanıcı tarafından reddedildi. Ürün belirli etkinlikler veya meslekler çevresinde kurulmayacak. Ekranlar, veri modeli ve başarı ölçütleri bu düzeltmeye uymalı; eski üç kategori geri getirilmemeli.

## Önerilen kararlar

Native iOS ve SwiftUI; cihazda veri; V0.1'de AI, hesap, backend ve ödeme yok. Tek “Ara ver” akışı; isteğe bağlı niyet aynı oturum motorunda. Dinlenmek, kendi başına düşünmek ve bir şeye yönelmek eşit derecede geçerli. Kısa pratik ile OS koruması ayrı. İlerleme özbildirim ve geçen süreyi karıştırmaz. Tasarım yönü “Gündelik editoryal”; kullanıcı değerlendirmesi bekliyor.

Eski CLAUDE.md'deki sabit program, fiyat, tasarım ve “pazar tamamen boş” iddialarını yeni kullanıcı kararı sayma. Kullanıcı Family Controls dağıtım izninin bulunduğunu doğruladı. Ana uygulama ve iki extension Family Controls/App Group içeren geliştirme profilleriyle imzalı cihaz derlemesinden geçti; dağıtım profilleri App Store/TestFlight aşamasında ayrıca doğrulanacak.

## Çalışma yöntemi

Her oturumda README, bu belge, ilgili tek plan bölümü ve hedef dosyaları oku. Rakip araştırmasını baştan tekrarlama. Bir görevde tek ölçülebilir sonuç üret. Önce çalışır akış, sonra gerekli sağlamlaştırma; aynı anda çok sayıda özellik ekleme.

Kısa görev sonunda: ne değişti, nasıl denendi, hangi belirsizlik kaldı ve sıradaki görev ID'si. Uygun yerde küçük commit. Modelin bağlamına bütün repo ve bütün araştırmayı tekrar tekrar yüklemek yerine hedefi daralt. Model seçiminin sağlayacağı kesin maliyet oranları bu planda hesaplanmadı.

Kullanıcıya kod yazdırma; gereken hesap/cihaz işlemlerini kısa ve somut anlat. Büyük tasarım değişikliğini kanıt olmadan başlatma. Başarısız engellemeyi sahte aktif göstergesiyle kapatma.

## İlk oturuma yapıştırılacak görev

> Önce kökteki AGENTS.md ve PROJECT_STATUS.md dosyalarını oku. Sıradaki iş olan imzalı iPhone 16e testini tamamlamaya yardım et. docs/05-CIHAZ-TESTI.md akışını izle; imza/provisioning veya çalışma hatası çıkarsa gerçek hata metnine göre kodu ya da proje yapılandırmasını düzelt. Fiziksel cihazda uygulama seçimi, shield, yaklaşık 15 dakika sonunda otomatik kaldırma, erken bitirme ve izin iptalini doğrulamadan ürün tasarımına geçme. Yapılan ve yapılmayan testleri PROJECT_STATUS.md içinde güncelle.

## Ardından kullanılacak görev kalıbı

> ARADA'da yalnızca [Txx] görevini tamamla. Bağımlılıkların tamamlandığını gerçek dosya ve test kaydından doğrula. İlgili plan bölümünü oku. Kabul ölçütünü sağlayacak değişikliği yap, gerekli testi çalıştır ve sonucu kısa raporla. Kapsamı genişletme; yapılmayan cihaz testini açıkça belirt.
