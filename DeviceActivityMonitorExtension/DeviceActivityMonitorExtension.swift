import DeviceActivity
import ActivityKit
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
        selection.applyShield(to: settingsStore)
    }

    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        guard activity == ScreenTimeConstants.activityName else { return }
        settingsStore.clearAllSettings()
        sharedDefaults?.removeObject(forKey: ScreenTimeConstants.protectionEndKey)
        let activities = Activity<AradaActivityAttributes>.activities
        Task {
            for activity in activities {
                await activity.end(nil, dismissalPolicy: .immediate)
            }
        }
    }
}
