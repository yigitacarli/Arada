# ARADA

**Telefonla arana, hayatına yer açacak küçük bir mesafe.**

Durum: Araştırma ve planlama tamamlandı; yeni uygulama henüz geliştirilmedi.
Plan tarihi: 10 Eylül 2026. İlk cihaz: iPhone 16e. Geliştirme: MacBook ve mevcut Apple Developer üyeliği.

## Başlangıç

1. [Ürün planı](docs/01-URUN-PLANI.md): Kime, hangi durumda, nasıl yardım edeceğiz?
2. [Araştırma ve tasarım](docs/02-ARASTIRMA-TASARIM.md): Rakipler, kaynaklar, ekranlar ve görsel yön.
3. [Teknik yol haritası](docs/03-TEKNIK-YOL-HARITASI.md): Aşamalar, sınırlar ve tamamlanma ölçütleri.
4. [Sonraki modele devir](docs/04-MODELE-DEVIR.md): İlk görev ve çalışma kuralları.

İlk sürüm için öneri: native iOS, SwiftUI, cihazda veri, hesap ve AI servisi olmadan tek bir güvenilir kullanım döngüsü. Platform seçimi ve etkinlik kategorilerinden bağımsız, geniş kitleye hitap eden ürün yaklaşımı kullanıcı tarafından doğrulandı. Tek “Ara ver” akışı önerilir; niyet seçimi isteğe bağlıdır. Diğer ürün kararları bu planın önerileridir.

## Repo temizliği

Kullanıcının açık isteğiyle önceki 39 dosya `ae8aea5` commit'inde kaldırıldı. Eski sürüm `4edc864` commit'inde erişilebilir. Git geçmişi silinmedi. Bu repodaki yeni belgeler eski uygulamanın devamı veya çalışır uygulama değildir.

## İlk teknik hedef

Gerçek iPhone üzerinde uygulama seç → 15 dakikalık koruma başlat → seçilen uygulamanın engellendiğini gör → ekran kilitliyken süre sonunda engelin kalktığını doğrula. Kısa pratikleri 15 dakikadan kısa işletim sistemi zamanlamasına bağlamadan tasarla.
