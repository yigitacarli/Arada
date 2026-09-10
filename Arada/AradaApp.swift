import SwiftUI

@main
struct AradaApp: App {
    @StateObject private var store = Store()

    var body: some Scene {
        WindowGroup {
            TodayView()
                .environmentObject(store)
                .tint(.aradaAccent)
        }
    }
}
