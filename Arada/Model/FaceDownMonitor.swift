import CoreMotion
import Foundation

/// Sayaç yalnızca telefon yüzüstüyken ilerler.
/// Cihaz koordinatlarında +Z ekseni ekrandan dışarı bakar; telefon yüzüstü
/// konulduğunda yerçekimi vektörü bu eksenle aynı yöne düşer (z ≈ +1).
@MainActor
final class FaceDownMonitor: ObservableObject {
    @Published private(set) var isFaceDown = false
    @Published private(set) var isAvailable = true

    private let motion = CMMotionManager()

    func start() {
        guard motion.isDeviceMotionAvailable else {
            isAvailable = false
            isFaceDown = true   // sensör yoksa oturumu engelleme
            return
        }
        motion.deviceMotionUpdateInterval = 0.2
        motion.startDeviceMotionUpdates(to: .main) { [weak self] data, _ in
            guard let self, let z = data?.gravity.z else { return }
            let down = z > 0.8
            if down != self.isFaceDown { self.isFaceDown = down }
        }
    }

    func stop() {
        motion.stopDeviceMotionUpdates()
    }
}
