import SwiftUI

@main
struct AradaApp: App {
    @StateObject private var screenTime = ScreenTimeService()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(screenTime)
                .preferredColorScheme(.light)
        }
    }
}
