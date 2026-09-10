import ManagedSettings
import ManagedSettingsUI
import UIKit

final class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        makeConfiguration()
    }

    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        makeConfiguration()
    }

    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        makeConfiguration()
    }

    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        makeConfiguration()
    }

    private func makeConfiguration() -> ShieldConfiguration {
        let ink = UIColor(red: 0.141, green: 0.157, blue: 0.125, alpha: 1)
        let paper = UIColor(red: 0.957, green: 0.941, blue: 0.902, alpha: 1)

        return ShieldConfiguration(
            backgroundBlurStyle: .systemMaterial,
            backgroundColor: paper,
            icon: UIImage(systemName: "pause.fill"),
            title: .init(text: "Biraz alan aç.", color: ink),
            subtitle: .init(text: "Bu uygulama seçtiğin aranın sonuna kadar kapalı.", color: ink)
        )
    }
}
