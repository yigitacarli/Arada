import Foundation

enum ProtectionState: Equatable {
    case inactive
    case starting
    case active(until: Date)
    case stopping
    case failed(message: String)
}

extension ProtectionState {
    var isActive: Bool {
        if case .active = self { return true }
        return false
    }
}
