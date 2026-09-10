import SwiftUI

struct TodayView: View {
    @EnvironmentObject private var store: Store
    @State private var showingSession = false

    var body: some View {
        ZStack {
            Color.aradaPaper.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    header
                    Divider1().padding(.vertical, 28)
                    todaysSession
                    Divider1().padding(.vertical, 28)
                    progress
                }
                .padding(.horizontal, 28)
                .padding(.top, 28)
                .padding(.bottom, 48)
            }
        }
        .fullScreenCover(isPresented: $showingSession) {
            SessionView(day: store.today)
                .environmentObject(store)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Arada")
                .font(.aradaDisplay(30, weight: .light))
                .foregroundStyle(Color.aradaInk)
            RailLabel(text: "today.subtitle")
        }
    }

    private var todaysSession: some View {
        VStack(alignment: .leading, spacing: 0) {
            if store.isFinished {
                Text("today.programComplete")
                    .font(.aradaDisplay(24, weight: .light))
                    .foregroundStyle(Color.aradaInk)
                    .padding(.bottom, 10)
                Text("today.programCompleteBody")
                    .font(.aradaBody)
                    .foregroundStyle(Color.aradaInk2)
            } else {
                RailLabel(text: store.didSessionToday ? "today.doneLabel" : "today.todayLabel")
                    .padding(.bottom, 14)

                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(String(store.today.minutes))
                        .font(.aradaNumeral(76))
                    Text("today.minutes")
                        .font(.aradaDisplay(20, weight: .light))
                        .foregroundStyle(Color.aradaInk2)
                }
                .foregroundStyle(Color.aradaInk)

                Text("today.weekDay \(store.today.week) \(store.today.dayOfWeek)")
                    .font(.aradaSmall)
                    .foregroundStyle(Color.aradaInk3)
                    .padding(.top, 4)

                Text("today.instruction")
                    .font(.aradaBody)
                    .foregroundStyle(Color.aradaInk2)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 20)

                QuietButton(
                    title: store.didSessionToday ? "today.again" : "today.start",
                    filled: !store.didSessionToday
                ) {
                    showingSession = true
                }
                .padding(.top, 26)
            }
        }
    }

    private var progress: some View {
        VStack(alignment: .leading, spacing: 0) {
            RailLabel(text: "today.progressLabel")
                .padding(.bottom, 16)

            ProgramGrid(completedDays: store.state.completedDays, totalDays: Program.totalDays)
                .padding(.bottom, 18)

            HStack(spacing: 0) {
                stat(value: daysText, label: "today.statDays")
                Spacer(minLength: 20)
                stat(value: focusedText, label: "today.statFocused")
            }
        }
    }

    private func stat(value: String, label: LocalizedStringKey) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(value)
                .font(.system(size: 20, weight: .light, design: .serif).monospacedDigit())
                .foregroundStyle(Color.aradaInk)
            RailLabel(text: label)
        }
    }

    private var daysText: String {
        String(store.state.completedDays) + "/" + String(Program.totalDays)
    }

    private var focusedText: String {
        let minutes = Int(store.totalFocusedSeconds) / 60
        if minutes < 60 { return String(minutes) + "m" }
        return String(minutes / 60) + "s " + String(minutes % 60) + "m"
    }
}
