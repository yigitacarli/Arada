import ActivityKit
import Foundation

struct AradaActivityAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {
        let endDate: Date
    }

    let startDate: Date
}
