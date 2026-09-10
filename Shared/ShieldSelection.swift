import FamilyControls
import ManagedSettings

extension FamilyActivitySelection {
    var hasShieldTargets: Bool {
        !applicationTokens.isEmpty || !categoryTokens.isEmpty || !webDomainTokens.isEmpty
    }

    func applyShield(to store: ManagedSettingsStore) {
        store.shield.applications = applicationTokens.isEmpty ? nil : applicationTokens
        store.shield.applicationCategories = categoryTokens.isEmpty ? nil : .specific(categoryTokens)
        store.shield.webDomains = webDomainTokens.isEmpty ? nil : webDomainTokens
        store.shield.webDomainCategories = categoryTokens.isEmpty ? nil : .specific(categoryTokens)
    }
}
