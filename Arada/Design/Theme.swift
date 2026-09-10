import SwiftUI
import UIKit

/// Kâğıt ve mürekkep. Tek vurgu rengi, iki tema.
/// Plandaki kural: uygulama uyaran yarışına girmez — parlak renk, gradyan, rozet yok.
extension Color {
    static let aradaPaper   = dynamic(light: 0xEDEFEC, dark: 0x121614)
    static let aradaPaper2  = dynamic(light: 0xE4E7E3, dark: 0x1A201D)
    static let aradaInk     = dynamic(light: 0x14181A, dark: 0xE3E8E4)
    static let aradaInk2    = dynamic(light: 0x4A5450, dark: 0xA3AEA8)
    static let aradaInk3    = dynamic(light: 0x75807B, dark: 0x7A857F)
    static let aradaRule    = dynamic(light: 0xD2D8D2, dark: 0x2A322E)
    static let aradaAccent  = dynamic(light: 0x2E6A63, dark: 0x74B8AC)
    static let aradaAccent2 = dynamic(light: 0xC9DBD5, dark: 0x24403B)

    private static func dynamic(light: UInt32, dark: UInt32) -> Color {
        Color(uiColor: UIColor { $0.userInterfaceStyle == .dark ? UIColor(rgb: dark) : UIColor(rgb: light) })
    }
}

private extension UIColor {
    convenience init(rgb: UInt32) {
        self.init(
            red:   CGFloat((rgb >> 16) & 0xFF) / 255,
            green: CGFloat((rgb >> 8) & 0xFF) / 255,
            blue:  CGFloat(rgb & 0xFF) / 255,
            alpha: 1
        )
    }
}

/// Görüntü fontu olarak sistemin serif ailesini (New York) kullanıyoruz.
/// Kitap için tasarlanmış bir yüz — ürünün derdiyle birebir örtüşüyor ve
/// uygulamaya font dosyası eklemek gerekmiyor.
extension Font {
    static func aradaDisplay(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .serif)
    }

    static func aradaNumeral(_ size: CGFloat) -> Font {
        .system(size: size, weight: .light, design: .serif).monospacedDigit()
    }

    static let aradaLabel = Font.system(size: 11, weight: .medium, design: .monospaced)
    static let aradaBody  = Font.system(size: 16, weight: .regular)
    static let aradaSmall = Font.system(size: 13, weight: .regular)
}

/// Küçük harfli, harf aralığı açılmış etiket. Rail/başlık işi görüyor.
struct RailLabel: View {
    let text: LocalizedStringKey

    var body: some View {
        Text(text)
            .font(.aradaLabel)
            .tracking(1.4)
            .textCase(.uppercase)
            .foregroundStyle(Color.aradaInk3)
    }
}
