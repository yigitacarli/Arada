import SwiftUI
import CoreImage

// MARK: - Duvar

/// Sıvalı duvarın tonu — ışık kaynağına yakın açık, köşelere doğru kararıyor.
struct WallGradient: View {
    @Environment(\.palette) private var p
    var dimmed: Bool = false

    var body: some View {
        RadialGradient(colors: [p.wallHi, p.wallLo],
                       center: UnitPoint(x: 0.6, y: 0.28),
                       startRadius: 0, endRadius: 560)
            .overlay(Color.black.opacity(dimmed ? 0.86 : 0))
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 0.7), value: dimmed)
    }
}

// MARK: - Sıva dokusu

/// Bir kez üretilen gri gürültü; duvara ince bir doku veriyor.
enum Grain {
    static let image: Image? = {
        guard let noise = CIFilter(name: "CIRandomGenerator")?.outputImage else { return nil }
        let box = CGRect(x: 0, y: 0, width: 180, height: 180)
        let mono = noise
            .applyingFilter("CIColorControls", parameters: [kCIInputSaturationKey: 0.0])
            .cropped(to: box)
        guard let cg = CIContext().createCGImage(mono, from: box) else { return nil }
        return Image(decorative: cg, scale: 1).resizable(resizingMode: .tile)
    }()
}

struct GrainOverlay: View {
    @Environment(\.palette) private var p

    var body: some View {
        if let g = Grain.image {
            g.opacity(p.isDark ? 0.09 : 0.05)
                .blendMode(p.isDark ? .overlay : .multiply)
                .allowsHitTesting(false)
                .ignoresSafeArea()
        }
    }
}

// MARK: - Marka işareti

/// Bir pencere: kare çerçeve, içinde aydınlıkla gölgenin yumuşak kenarı.
/// O kenarın adı zaten "arada".
struct BrandMark: View {
    @Environment(\.palette) private var p
    var size: CGFloat

    var body: some View {
        Rectangle()
            .fill(LinearGradient(
                stops: [
                    .init(color: p.beam, location: 0.30),
                    .init(color: p.ink,  location: 0.62)
                ],
                startPoint: UnitPoint(x: 0.05, y: 0),
                endPoint:   UnitPoint(x: 0.85, y: 1)))
            .frame(width: size, height: size)
            .overlay(Rectangle().stroke(p.ink, lineWidth: max(1, size * 0.05)))
    }
}

// MARK: - Sabit ışık (Bugün ekranı)

/// Pencereden düşen, sabit duran ışık dörtgeni.
struct StaticBeam: View {
    @Environment(\.palette) private var p

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            Path { path in
                path.move(to:    CGPoint(x: w * 0.09, y: h * 0.22))
                path.addLine(to: CGPoint(x: w * 0.83, y: h * 0.14))
                path.addLine(to: CGPoint(x: w * 0.95, y: h * 0.52))
                path.addLine(to: CGPoint(x: w * 0.20, y: h * 0.62))
                path.closeSubpath()
            }
            .fill(LinearGradient(
                colors: [p.beam.opacity(0.90), p.beam.opacity(0.5), p.beamEnd.opacity(0.10)],
                startPoint: .topLeading, endPoint: .bottomTrailing))
            .blur(radius: 28)
        }
        .allowsHitTesting(false)
        .ignoresSafeArea()
    }
}

// MARK: - Yürüyen ışık (Oturum ekranı)

/// Işık pencereden girer ve karşı kenara yürür. `progress` 0→1 arası;
/// mesafe sabit olduğu için 2 dakikalık oturumda da 22 dakikalıkta da
/// aynı yolu kat eder — yani süre uzadıkça ışık görünür şekilde yavaşlar.
struct WalkingLight: View {
    @Environment(\.palette) private var p
    var progress: Double

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            let travel = w * 0.60
            let x = w * 0.05 + travel * progress
            let beamW = w * 0.40

            ZStack {
                Path { path in
                    path.move(to:    CGPoint(x: x,                     y: h * 0.30))
                    path.addLine(to: CGPoint(x: x + beamW,             y: h * 0.24))
                    path.addLine(to: CGPoint(x: x + beamW + w * 0.045, y: h * 0.70))
                    path.addLine(to: CGPoint(x: x + w * 0.03,          y: h * 0.76))
                    path.closeSubpath()
                }
                .fill(LinearGradient(
                    colors: [p.beam.opacity(0.55), p.beam.opacity(0.34), p.beamEnd.opacity(0.08)],
                    startPoint: .topLeading, endPoint: .bottomTrailing))
                .blur(radius: 26)

                // ışığın varması gereken kenar — neredeyse görünmez bir iz
                Path { path in
                    path.move(to:    CGPoint(x: w - 30, y: h * 0.28))
                    path.addLine(to: CGPoint(x: w - 30, y: h * 0.72))
                }
                .stroke(p.beam.opacity(0.16), lineWidth: 1)
            }
        }
        .allowsHitTesting(false)
        .ignoresSafeArea()
    }
}
