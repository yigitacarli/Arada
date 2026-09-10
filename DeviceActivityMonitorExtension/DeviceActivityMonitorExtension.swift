import DeviceActivity
import FamilyControls
import Foundation
import ManagedSettings

final class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    private let settingsStore = ManagedSettingsStore(named: ScreenTimeConstants.storeName)
    private let sharedDefaults = UserDefaults(suiteName: ScreenTimeConstants.appGroupIdentifier)

    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        guard activity == ScreenTimeConstants.activityName,
              let data = sharedDefaults?.data(forKey: ScreenTimeConstants.selectionKey),
              let selection = try? PropertyListDecoder().decode(FamilyActivitySelection.self, from: data) else {
            return
        }
        settingsStore.shield.applications = selection.applicationTokens
    }

    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        guard activity == ScreenTimeConstants.activityName else { return }
        settingsStore.clearAllSettings()
        sharedDefaults?.removeObject(forKey: ScreenTimeConstants.protectionEndKey)
    }
}
