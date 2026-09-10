# Sonraki geliştirme oturumuna devir

## Doğrulananlar

- Kullanıcı Türkçe iletişim istiyor; önce kendi kullanımı, sonra geniş kitle için ARADA.
- iPhone 16e, MacBook ve Apple Developer üyeliği var.
- Repo: https://github.com/yigitacarli/Arada, main.
- Kullanıcı tüm eski dosyaların silinmesini açıkça istedi. Temizlik commit'i: ae8aea5. Eski commit: 4edc864.
- Bu devirde yeni uygulama kodu yazılmadı veya cihazda test edilmedi.

## Kullanıcının kapsam düzeltmesi

Kitap, yemek ve yol yalnızca örneklerdi. Bunları kategoriye dönüştüren önceki plan kullanıcı tarafından reddedildi. Ürün belirli etkinlikler veya meslekler çevresinde kurulmayacak. Ekranlar, veri modeli ve başarı ölçütleri bu düzeltmeye uymalı; eski üç kategori geri getirilmemeli.

## Önerilen kararlar

Native iOS ve SwiftUI; cihazda veri; V0.1'de AI, hesap, backend ve ödeme yok. Tek “Ara ver” akışı; isteğe bağlı niyet aynı oturum motorunda. Dinlenmek, kendi başına düşünmek ve bir şeye yönelmek eşit derecede geçerli. Kısa pratik ile OS koruması ayrı. İlerleme özbildirim ve geçen süreyi karıştırmaz. Tasarım yönü “Gündelik editoryal”; kullanıcı değerlendirmesi bekliyor.

Eski CLAUDE.md'deki sabit program, fiyat, tasarım ve “pazar tamamen boş” iddialarını yeni kullanıcı kararı sayma. Family Controls onayı eski notta yazıyor, portalda doğrulanmadı. Kullanıcı üyeliği doğruladı; spesifik target yetkilerini doğrulamadı.

## Çalışma yöntemi

Her oturumda README, bu belge, ilgili tek plan bölümü ve hedef dosyaları oku. Rakip araştırmasını baştan tekrarlama. Bir görevde tek ölçülebilir sonuç üret. Önce çalışır akış, sonra gerekli sağlamlaştırma; aynı anda çok sayıda özellik ekleme.

Kısa görev sonunda: ne değişti, nasıl denendi, hangi belirsizlik kaldı ve sıradaki görev ID'si. Uygun yerde küçük commit. Modelin bağlamına bütün repo ve bütün araştırmayı tekrar tekrar yüklemek yerine hedefi daralt. Model seçiminin sağlayacağı kesin maliyet oranları bu planda hesaplanmadı.

Kullanıcıya kod yazdırma; gereken hesap/cihaz işlemlerini kısa ve somut anlat. Büyük tasarım değişikliğini kanıt olmadan başlatma. Başarısız engellemeyi sahte aktif göstergesiyle kapatma.

## İlk oturuma yapıştırılacak görev

> ARADA reposundaki README.md, docs/04-MODELE-DEVIR.md ve docs/03-TEKNIK-YOL-HARITASI.md dosyalarını oku. Yalnızca T00–T02 kapsamını ele al. Önce mevcut Xcode/SDK ve gerçek cihaz hazırlığını incele; Family Controls yetkisinin app ve gerekli extension target'larında doğrulanmış mı bekleyen mi olduğunu ayır. Sonra minimum native iOS deneyi oluştur: kullanıcı seçimiyle bir uygulamaya 15 dakikalık koruma koy ve ekran kilitliyken süre sonunda kaldırmayı gerçek iPhone 16e üzerinde test edilebilir hale getir. 2 dakikalık pratik için desteklenmeyen arka plan timer'ı uydurma. Tasarım ekranları, backend veya AI ekleme. Cihaza erişemiyorsan derlenebilir teslimi hazırla, kullanıcıya en kısa cihaz testini ver ve test yapılmış gibi raporlama. Sonuçta komutları, kanıtı ve kalan tek sonraki işi belirt.

## Ardından kullanılacak görev kalıbı

> ARADA'da yalnızca [Txx] görevini tamamla. Bağımlılıkların tamamlandığını gerçek dosya ve test kaydından doğrula. İlgili plan bölümünü oku. Kabul ölçütünü sağlayacak değişikliği yap, gerekli testi çalıştır ve sonucu kısa raporla. Kapsamı genişletme; yapılmayan cihaz testini açıkça belirt.
