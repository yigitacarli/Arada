import DeviceActivity
import FamilyControls
import Foundation
import ManagedSettings

@MainActor
final class ScreenTimeService: ObservableObject {
    @Published private(set) var authorizationStatus = AuthorizationCenter.shared.authorizationStatus
    @Published var selection: FamilyActivitySelection
    @Published private(set) var protectionState: ProtectionState = .inactive
    @Published private(set) var liveActivityMessage: String?

    private let authorizationCenter = AuthorizationCenter.shared
    private let activityCenter = DeviceActivityCenter()
    private let settingsStore = ManagedSettingsStore(named: ScreenTimeConstants.storeName)
    private let sharedDefaults = UserDefaults(suiteName: ScreenTimeConstants.appGroupIdentifier)
    private let liveActivityController = LiveActivityController()

    init() {
        if let data = sharedDefaults?.data(forKey: ScreenTimeConstants.selectionKey),
           let savedSelection = try? PropertyListDecoder().decode(FamilyActivitySelection.self, from: data) {
            selection = savedSelection
        } else {
            selection = FamilyActivitySelection()
        }
        reconcileProtectionState()
    }

    var selectionSummary: String {
        var parts: [String] = []
        appendCount(selection.applicationTokens.count, singular: "uygulama", plural: "uygulama", to: &parts)
        appendCount(selection.categoryTokens.count, singular: "kategori", plural: "kategori", to: &parts)
        appendCount(selection.webDomainTokens.count, singular: "site", plural: "site", to: &parts)
        return parts.isEmpty ? "Henüz seçim yok" : parts.joined(separator: " · ")
    }

    var canStartProtection: Bool {
        authorizationStatus == .approved && selection.hasShieldTargets && !protectionState.isActive
    }

    func requestAuthorization() async {
        do {
            try await authorizationCenter.requestAuthorization(for: .individual)
            authorizationStatus = authorizationCenter.authorizationStatus
        } catch {
            authorizationStatus = authorizationCenter.authorizationStatus
            protectionState = .failed(message: "Screen Time izni verilemedi. Ayarlar'dan ARADA erişimini kontrol et.")
        }
    }

    func saveSelection() {
        guard let data = try? PropertyListEncoder().encode(selection) else { return }
        sharedDefaults?.set(data, forKey: ScreenTimeConstants.selectionKey)
    }

    func startProtection(minutes: Int = 15, now: Date = Date()) {
        authorizationStatus = authorizationCenter.authorizationStatus
        guard authorizationStatus == .approved else {
            protectionState = .failed(message: "Koruma için önce Screen Time izni gerekiyor.")
            return
        }
        guard selection.hasShieldTargets else {
            protectionState = .failed(message: "Korumak istediğin en az bir uygulama, kategori veya site seç.")
            return
        }

        protectionState = .starting
        saveSelection()
        stopSystemProtection(clearState: false)

        let end = now.addingTimeInterval(TimeInterval(minutes * 60))
        let calendar = Calendar.current
        let schedule = DeviceActivitySchedule(
            intervalStart: calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now),
            intervalEnd: calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: end),
            repeats: false
        )

        do {
            try activityCenter.startMonitoring(ScreenTimeConstants.activityName, during: schedule)
            selection.applyShield(to: settingsStore)
            sharedDefaults?.set(end, forKey: ScreenTimeConstants.protectionEndKey)
            protectionState = .active(until: end)
            do {
                try liveActivityController.start(from: now, until: end)
                liveActivityMessage = nil
            } catch {
                liveActivityMessage = error.localizedDescription
            }
        } catch {
            settingsStore.clearAllSettings()
            sharedDefaults?.removeObject(forKey: ScreenTimeConstants.protectionEndKey)
            protectionState = .failed(message: "Koruma başlatılamadı: \(error.localizedDescription)")
            liveActivityMessage = nil
        }
    }

    func stopProtection() {
        protectionState = .stopping
        stopSystemProtection(clearState: true)
    }

    func refresh() {
        authorizationStatus = authorizationCenter.authorizationStatus
        if authorizationStatus != .approved {
            stopSystemProtection(clearState: true)
            protectionState = .failed(message: "Screen Time izni kapatılmış. Koruma kaldırıldı.")
            return
        }
        reconcileProtectionState()
    }

    private func reconcileProtectionState(now: Date = Date()) {
        guard let end = sharedDefaults?.object(forKey: ScreenTimeConstants.protectionEndKey) as? Date else {
            protectionState = .inactive
            return
        }
        if end > now {
            protectionState = .active(until: end)
        } else {
            stopSystemProtection(clearState: true)
        }
    }

    private func stopSystemProtection(clearState: Bool) {
        activityCenter.stopMonitoring([ScreenTimeConstants.activityName])
        settingsStore.clearAllSettings()
        sharedDefaults?.removeObject(forKey: ScreenTimeConstants.protectionEndKey)
        liveActivityController.endCurrentActivities()
        liveActivityMessage = nil
        if clearState { protectionState = .inactive }
    }

    private func appendCount(
        _ count: Int,
        singular: String,
        plural: String,
        to parts: inout [String]
    ) {
        guard count > 0 else { return }
        parts.append("\(count) \(count == 1 ? singular : plural)")
    }
}
