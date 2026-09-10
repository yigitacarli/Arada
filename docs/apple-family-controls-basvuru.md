# Family Controls (Distribution) başvurusu

> **Durum: ONAYLANDI — 10 Eylül 2026.** Apple yetkiyi aynı gün hesaba tanımladı.
> Aşağıdaki metin arşiv olarak duruyor; uzantı kimlikleri için tekrar gerekirse kullanılır.
> Sıradaki iş: Xcode'da her hedefe *Signing & Capabilities → + Capability → Family Controls*
> eklemek. Otomatik imzalamada Xcode App ID'leri kendisi oluşturuyor.

## Nereye

<https://developer.apple.com/contact/request/family-controls-distribution/>

(Apple Developer hesabınla giriş yapmış olman gerekiyor.)

## Ne yazacaksın

Formdaki açıklama alanına aşağıdaki metni **olduğu gibi** yapıştır. İngilizce yazıldı,
çünkü formu Apple'ın ekibi okuyor.

---

Arada is a personal attention-training app for a single user acting on their own device.

**Relationship model.** There is no parent/child, employer/employee, school, or any other
third-party supervision relationship. The person who applies a restriction is the same person
who owns the device, and they can remove it themselves at any time. Arada has no account
system, no pairing flow, and no remote administration of any kind.

**How each API is used.**

- `FamilyControls` — presents `FamilyActivityPicker` so the user chooses, on their own device,
  which applications and categories they want to place behind a shield during their own
  training sessions.
- `ManagedSettings` — applies that shield only for the duration the user selected, and clears
  it when the session ends.
- `DeviceActivity` — schedules those user-defined windows and delivers threshold callbacks so a
  session can end automatically without the app running in the foreground.
- `ShieldConfiguration` / `ShieldAction` — replaces the default block screen with a calm custom
  screen that offers a short offline alternative (for example: read one page, look out of the
  window) instead of a generic denial message.

**Privacy.** Selections stay on device as opaque `ApplicationToken` values. We never resolve
them to app identities, never transmit them, and operate no server that could receive them.
The app collects no personal data and requires no sign-in.

**Category.** Screen Time / personal self-control, comparable to existing App Store apps such as
Opal, Jomo and one sec.

---

## Bundle kimlikleri

Formda ana uygulamanın kimliğini soracak:

    app.arada.ios

Faz 2'de şu uzantıları ekleyeceğiz. Bunları **şimdiden** yaz — sonradan her biri için ayrı
onay beklemek haftalar kaybettirir:

    app.arada.ios.monitor        (DeviceActivityMonitorExtension)
    app.arada.ios.shield         (ShieldConfigurationExtension)
    app.arada.ios.shieldaction   (ShieldActionExtension)
    app.arada.ios.report         (DeviceActivityReportExtension)

Formun serbest metin alanına şu cümleyi ekle:

> In addition to the main application bundle identifier, this request covers the following
> app extension bundle identifiers, which are part of the same application:
> app.arada.ios.monitor, app.arada.ios.shield, app.arada.ios.shieldaction, app.arada.ios.report

## Onay geldikten sonra

developer.apple.com → Certificates, Identifiers & Profiles → Identifiers → her bir kimlik →
Additional Capabilities → **Family Controls (Distribution)** işaretle.

## Reddedilirse

Plan çökmüyor. Sıkılma Antrenmanı — yani şu an elimizdeki ürün — hiçbir Apple yetkisine
bağlı değil. Engelleme özelliği olmadan da App Store'a çıkabiliriz; itiraz sürecini
paralelde yürütürüz.
