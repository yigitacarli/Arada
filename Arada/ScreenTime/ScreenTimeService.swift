import DeviceActivity
import FamilyControls
import Foundation
import ManagedSettings

@MainActor
final class ScreenTimeService: ObservableObject {
    @Published private(set) var authorizationStatus = AuthorizationCenter.shared.authorizationStatus
    @Published var selection: FamilyActivitySelection
    @Published private(set) var protectionState: ProtectionState = .inactive

    private let authorizationCenter = AuthorizationCenter.shared
    private let activityCenter = DeviceActivityCenter()
    private let settingsStore = ManagedSettingsStore(named: ScreenTimeConstants.storeName)
    private let sharedDefaults = UserDefaults(suiteName: ScreenTimeConstants.appGroupIdentifier)

    init() {
        if let data = sharedDefaults?.data(forKey: ScreenTimeConstants.selectionKey),
           let savedSelection = try? PropertyListDecoder().decode(FamilyActivitySelection.self, from: data) {
            selection = savedSelection
        } else {
            selection = FamilyActivitySelection()
        }
        reconcileProtectionState()
    }

    var selectedApplicationCount: Int {
        selection.applicationTokens.count
    }

    var canStartProtection: Bool {
        authorizationStatus == .approved && selectedApplicationCount > 0 && !protectionState.isActive
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
        guard !selection.applicationTokens.isEmpty else {
            protectionState = .failed(message: "Korumak istediğin en az bir uygulamayı seç.")
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
            settingsStore.shield.applications = selection.applicationTokens
            sharedDefaults?.set(end, forKey: ScreenTimeConstants.protectionEndKey)
            protectionState = .active(until: end)
        } catch {
            settingsStore.clearAllSettings()
            sharedDefaults?.removeObject(forKey: ScreenTimeConstants.protectionEndKey)
            protectionState = .failed(message: "Koruma başlatılamadı: \(error.localizedDescription)")
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
        if clearState { protectionState = .inactive }
    }
}
