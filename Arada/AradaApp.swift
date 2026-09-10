import SwiftUI

@main
struct AradaApp: App {
    @StateObject private var store = Store()

    // Palet günün saatine göre uygulama açılışında belirlenir.
    private let daylight = DayLight.now

    var body: some Scene {
        WindowGroup {
            TodayView()
                .environmentObject(store)
                .environment(\.palette, daylight.palette)
                .preferredColorScheme(daylight.palette.isDark ? .dark : .light)
        }
    }
}
