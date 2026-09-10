import SwiftUI

struct TodayView: View {
    @EnvironmentObject private var store: Store
    @Environment(\.palette) private var p
    @State private var showingSession = false

    var body: some View {
        ZStack {
            WallGradient()
            StaticBeam()
            GrainOverlay()

            VStack(alignment: .leading, spacing: 0) {
                masthead
                Spacer(minLength: 20)
                hero
                Spacer(minLength: 20)
                footer
            }
            .padding(.horizontal, 30)
            .padding(.top, 18)
            .padding(.bottom, 30)
        }
        .fullScreenCover(isPresented: $showingSession) {
            SessionView(day: store.today)
                .environmentObject(store)
                .environment(\.palette, p)
        }
    }

    private var masthead: some View {
        HStack(spacing: 9) {
            BrandMark(size: 17)
            Text("arada")
                .font(.serifDisplay(19))
                .tracking(0.6)
                .foregroundStyle(p.ink)
        }
    }

    @ViewBuilder
    private var hero: some View {
        if store.isFinished {
            VStack(alignment: .leading, spacing: 14) {
                Text("today.programComplete")
                    .font(.serifDisplay(46))
                    .foregroundStyle(p.ink)
                    .fixedSize(horizontal: false, vertical: true)
                Text("today.programCompleteBody")
                    .font(.serifText(17, .light))
                    .lineSpacing(3)
                    .foregroundStyle(p.inkSoft)
                    .fixedSize(horizontal: false, vertical: true)
            }
        } else {
            VStack(alignment: .leading, spacing: 0) {
                Text(String(store.today.minutes))
                    .font(.serifDisplay(168))
                    .foregroundStyle(p.ink)
                    .kerning(-2)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                Text("today.heroCaption")
                    .font(.serifText(21, .light))
                    .italic()
                    .foregroundStyle(p.inkSoft)
                    .padding(.top, 10)
                RailLabel(text: "today.weekDay \(store.today.week) \(store.today.dayOfWeek)")
                    .padding(.top, 18)
            }
        }
    }

    private var footer: some View {
        VStack(alignment: .leading, spacing: 20) {
            if !store.isFinished {
                Text(store.didSessionToday ? "today.doneToday" : "today.instruction")
                    .font(.serifText(16.5, .light))
                    .lineSpacing(4)
                    .foregroundStyle(p.inkSoft)
                    .fixedSize(horizontal: false, vertical: true)

                QuietButton(title: store.didSessionToday ? "today.again" : "today.start",
                            filled: !store.didSessionToday) {
                    showingSession = true
                }
            }

            ProgramLadder(completedDays: store.state.completedDays)

            HStack(spacing: 28) {
                stat(daysText, "today.statDays")
                stat(focusedText, "today.statFocused")
            }
            .padding(.top, 2)
        }
    }

    private func stat(_ value: String, _ label: LocalizedStringKey) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(value)
                .font(.serifDisplay(22))
                .monospacedDigit()
                .foregroundStyle(p.ink)
            RailLabel(text: label)
        }
    }

    private var daysText: String {
        "\(store.state.completedDays)/\(Program.totalDays)"
    }

    private var focusedText: String {
        let minutes = Int(store.totalFocusedSeconds) / 60
        if minutes < 60 { return "\(minutes) dk" }
        return "\(minutes / 60) sa \(minutes % 60) dk"
    }
}
