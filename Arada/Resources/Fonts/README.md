# Fontlar

İkisi de **SIL Open Font License 1.1** — ticari uygulamada gömülü kullanım serbest,
lisans metninin uygulamada bir yerde bulunması yeterli (Ayarlar > Hakkında ekranına eklenecek).

| Dosya | Aile | Kaynak |
|---|---|---|
| `InstrumentSerif-Regular.ttf` | Instrument Serif | github.com/Instrument/instrument-serif |
| `InstrumentSerif-Italic.ttf` | Instrument Serif | aynı |
| `Newsreader.ttf` | Newsreader (değişken) | github.com/productiontype/Newsreader |
| `Newsreader-Italic.ttf` | Newsreader (değişken) | aynı |

## Newsreader değişken font notu

Newsreader değişken bir font; SwiftUI'da `Font.custom("Newsreader", size:).weight(.light)`
iOS 17'de ağırlık eksenini uygular. Xcode'da önizlemede ışık/regular ayrımı görünmüyorsa
`productiontype/Newsreader` deposundan `Newsreader16pt-Light.ttf` ve
`Newsreader16pt-Regular.ttf` statik kesitlerini indirip bunların yerine koy,
`project.yml` içindeki `UIAppFonts` listesini güncelle.

`project.yml` → `UIAppFonts` bu dört dosyayı bundle köküne kopyalıyor (XcodeGen
`.ttf` dosyalarını otomatik olarak Copy Bundle Resources'a ekliyor).
