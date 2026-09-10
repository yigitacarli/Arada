import ActivityKit
import SwiftUI
import WidgetKit

@main
struct AradaLiveActivityBundle: WidgetBundle {
    var body: some Widget {
        AradaLiveActivity()
    }
}

struct AradaLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: AradaActivityAttributes.self) { context in
            HStack(spacing: 16) {
                pauseSymbol

                VStack(alignment: .leading, spacing: 4) {
                    Text("ARADA")
                        .font(.caption.weight(.semibold))
                        .tracking(2)
                        .foregroundStyle(olive)
                    Text("Kendine alan açıyorsun")
                        .font(.headline)
                        .foregroundStyle(ink)
                }

                Spacer(minLength: 8)

                countdown(until: context.state.endDate)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(ink)
            }
            .padding(.horizontal, 18)
            .activityBackgroundTint(paper)
            .activitySystemActionForegroundColor(ink)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    pauseSymbol
                }
                DynamicIslandExpandedRegion(.center) {
                    Text("Kendine alan açıyorsun")
                        .font(.headline)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    countdown(until: context.state.endDate)
                        .font(.headline.monospacedDigit())
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Seçtiklerin süre bitince yeniden açılacak.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            } compactLeading: {
                Image(systemName: "pause.fill")
                    .foregroundStyle(olive)
            } compactTrailing: {
                countdown(until: context.state.endDate)
                    .font(.caption2.monospacedDigit())
            } minimal: {
                Image(systemName: "pause.fill")
                    .foregroundStyle(olive)
            }
            .keylineTint(olive)
        }
    }

    private var pauseSymbol: some View {
        Image(systemName: "pause.fill")
            .font(.title3.weight(.semibold))
            .foregroundStyle(olive)
            .frame(width: 42, height: 42)
            .background(olive.opacity(0.12), in: Circle())
    }

    private func countdown(until endDate: Date) -> some View {
        Text(timerInterval: Date()...endDate, countsDown: true)
            .monospacedDigit()
            .multilineTextAlignment(.trailing)
    }

    private var paper: Color { Color(red: 0.957, green: 0.941, blue: 0.902) }
    private var ink: Color { Color(red: 0.141, green: 0.157, blue: 0.125) }
    private var olive: Color { Color(red: 0.275, green: 0.341, blue: 0.235) }
}
