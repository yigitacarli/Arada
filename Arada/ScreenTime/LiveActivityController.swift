import ActivityKit
import Foundation

@MainActor
final class LiveActivityController {
    func start(from startDate: Date, until endDate: Date) throws {
        endCurrentActivities()

        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            throw LiveActivityError.disabled
        }

        let attributes = AradaActivityAttributes(startDate: startDate)
        let state = AradaActivityAttributes.ContentState(endDate: endDate)
        let content = ActivityContent(state: state, staleDate: endDate)
        _ = try Activity<AradaActivityAttributes>.request(
            attributes: attributes,
            content: content,
            pushType: nil
        )
    }

    func endCurrentActivities() {
        let activities = Activity<AradaActivityAttributes>.activities
        Task {
            for activity in activities {
                await activity.end(nil, dismissalPolicy: .immediate)
            }
        }
    }
}

enum LiveActivityError: LocalizedError {
    case disabled

    var errorDescription: String? {
        "Canlı Etkinlikler kapalı. Ayarlar'dan ARADA için açabilirsin."
    }
}
