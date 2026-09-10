import SwiftUI

// MARK: - Günün ışığı

/// Arada'nın rengi dışarıdan gelir. Duvara vuran ışık günün saatine göre kayar:
/// sabah soğuk ve solgun, öğleden sonra sıcak, akşam kehribar, gece ay ışığı.
/// Vurgu rengi yoktur — ışığın kendisi vurgudur.
enum DayLight {
    case dawn, morning, afternoon, dusk, night

    static var now: DayLight {
        switch Calendar.current.component(.hour, from: Date()) {
        case 5..<8:   return .dawn
        case 8..<12:  return .morning
        case 12..<17: return .afternoon
        case 17..<21: return .dusk
        default:      return .night
        }
    }

    var palette: Palette {
        switch self {
        case .dawn:
            return Palette(wallHi: 0xD4D1CB, wallLo: 0xB6B1A7,
                           beam: 0xEDEEEA, beamEnd: 0xDCDDD6,
                           ink: 0x2A251E, inkSoft: 0x5F594E, inkFaint: 0x8A8377,
                           isDark: false)
        case .morning:
            return Palette(wallHi: 0xD7D3C7, wallLo: 0xB9B3A5,
                           beam: 0xF5F1E4, beamEnd: 0xE9E1CC,
                           ink: 0x221E17, inkSoft: 0x554E42, inkFaint: 0x827A6B,
                           isDark: false)
        case .afternoon:
            return Palette(wallHi: 0xD7D1C5, wallLo: 0xB2AB9D,
                           beam: 0xFBF4E2, beamEnd: 0xE7D9BA,
                           ink: 0x221E17, inkSoft: 0x453E32, inkFaint: 0x6E6555,
                           isDark: false)
        case .dusk:
            return Palette(wallHi: 0xCBBBA4, wallLo: 0x9C8B72,
                           beam: 0xF2DBAF, beamEnd: 0xD8B487,
                           ink: 0x241D14, inkSoft: 0x4A3F2E, inkFaint: 0x746247,
                           isDark: false)
        case .night:
            return Palette(wallHi: 0x2C2823, wallLo: 0x171512,
                           beam: 0xD9DBD2, beamEnd: 0x8C8E84,
                           ink: 0xE8E1D2, inkSoft: 0x8A8072, inkFaint: 0x574F44,
                           isDark: true)
        }
    }
}

struct Palette {
    let wallHi, wallLo, beam, beamEnd, ink, inkSoft, inkFaint: Color
    let isDark: Bool

    init(wallHi: UInt32, wallLo: UInt32, beam: UInt32, beamEnd: UInt32,
         ink: UInt32, inkSoft: UInt32, inkFaint: UInt32, isDark: Bool) {
        self.wallHi = Color(hex: wallHi)
        self.wallLo = Color(hex: wallLo)
        self.beam = Color(hex: beam)
        self.beamEnd = Color(hex: beamEnd)
        self.ink = Color(hex: ink)
        self.inkSoft = Color(hex: inkSoft)
        self.inkFaint = Color(hex: inkFaint)
        self.isDark = isDark
    }
}

extension Color {
    init(hex: UInt32) {
        self.init(.sRGB,
                  red:   Double((hex >> 16) & 0xFF) / 255,
                  green: Double((hex >> 8) & 0xFF) / 255,
                  blue:  Double(hex & 0xFF) / 255)
    }
}

// MARK: - Palet ortam değeri

private struct PaletteKey: EnvironmentKey {
    static let defaultValue = DayLight.afternoon.palette
}

extension EnvironmentValues {
    var palette: Palette {
        get { self[PaletteKey.self] }
        set { self[PaletteKey.self] = newValue }
    }
}

// MARK: - Tipografi

extension Font {
    /// Instrument Serif — rakamlar ve logotype. Yüksek kontrastlı, keskin.
    static func serifDisplay(_ size: CGFloat) -> Font {
        .custom("Instrument Serif", size: size)
    }

    /// Newsreader — metin. Türkçe tam destekli.
    /// Not: Newsreader değişken bir font; ağırlık ekseni iOS 17'de çalışıyor.
    /// Işık ağırlık düşmezse Mac'te statik kesitler eklenecek.
    static func serifText(_ size: CGFloat, _ weight: Font.Weight = .regular) -> Font {
        .custom("Newsreader", size: size).weight(weight)
    }
}

/// Küçük harfli, harf aralığı açılmış etiket.
struct RailLabel: View {
    @Environment(\.palette) private var p
    let text: LocalizedStringKey

    var body: some View {
        Text(text)
            .font(.serifText(10.5))
            .tracking(2)
            .textCase(.uppercase)
            .foregroundStyle(p.inkFaint)
    }
}
