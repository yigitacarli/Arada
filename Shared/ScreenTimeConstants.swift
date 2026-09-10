import DeviceActivity
import ManagedSettings

enum ScreenTimeConstants {
    static let appGroupIdentifier = "group.app.arada.shared"
    static let selectionKey = "selectedApplications"
    static let protectionEndKey = "protectionEnd"
    static let storeName = ManagedSettingsStore.Name("arada.protection")
    static let activityName = DeviceActivityName("arada.protection")
}
