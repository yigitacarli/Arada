import SwiftUI
import AudioToolbox
import UIKit

struct SessionView: View {
    let day: Program.Day

    @EnvironmentObject private var store: Store
    @Environment(\.dismiss) private var dismiss
    @Environment(\.palette) private var p
    @StateObject private var motion = FaceDownMonitor()

    @State private var focused: TimeInterval = 0
    @State private var lastTick: Date?
    @State private var phase: Phase = .waiting

    private enum Phase { case waiting, running, done }

    private let tick = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()

    private var progress: Double { min(1, focused / day.seconds) }

    var body: some View {
        ZStack {
            WallGradient(dimmed: phase == .running)

            if phase != .waiting {
                WalkingLight(progress: phase == .done ? 1 : progress)
                    .animation(.linear(duration: 0.28), value: progress)
            }

            GrainOverlay()
            content
        }
        .onAppear {
            motion.start()
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            motion.stop()
            UIApplication.shared.isIdleTimerDisabled = false
        }
        .onReceive(tick) { _ in advance() }
        .onChange(of: motion.isFaceDown) { _, down in
            if down && phase == .waiting { phase = .running }
            if !down { lastTick = nil }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch phase {
        case .waiting:
            VStack(spacing: 0) {
                Spacer()
                BrandMark(size: 27).opacity(0.9)
                Text("session.turnOver")
                    .font(.serifDisplay(40))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(p.ink)
                    .padding(.top, 32)
                Text("session.turnOverBody")
                    .font(.serifText(16.5, .light))
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
                    .foregroundStyle(p.inkSoft)
                    .frame(maxWidth: 280)
                    .padding(.top, 20)
                Spacer()
                Button("session.cancel") { dismiss() }
                    .font(.serifText(11))
                    .tracking(2)
                    .textCase(.uppercase)
                    .foregroundStyle(p.inkFaint)
            }
            .padding(.horizontal, 34)
            .padding(.bottom, 40)

        case .running:
            VStack(spacing: 0) {
                Spacer()
                if !motion.isFaceDown {
                    Text("session.paused")
                        .font(.serifText(15, .light))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.white.opacity(0.40))
                }
                Spacer()
                Button("session.giveUp") { end(completed: false) }
                    .font(.serifText(11))
                    .tracking(2)
                    .textCase(.uppercase)
                    .foregroundStyle(Color.white.opacity(motion.isFaceDown ? 0 : 0.32))
            }
            .padding(.bottom, 44)
            .animation(.easeInOut(duration: 0.5), value: motion.isFaceDown)

        case .done:
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                Text("session.done")
                    .font(.serifDisplay(60))
                    .foregroundStyle(p.ink)
                Text("session.doneBody \(day.minutes)")
                    .font(.serifText(17.5, .light))
                    .lineSpacing(3)
                    .foregroundStyle(p.inkSoft)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 16)
                RailLabel(text: "session.doneNote")
                    .padding(.top, 22)
                Hairline().padding(.vertical, 26)
                Button { dismiss() } label: {
                    Text("session.close")
                        .font(.serifText(11))
                        .tracking(2.4)
                        .textCase(.uppercase)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 17)
                        .foregroundStyle(p.ink)
                        .overlay(Rectangle().stroke(p.ink.opacity(0.34), lineWidth: 1))
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 40)
        }
    }

    private func advance() {
        guard phase == .running, motion.isFaceDown else {
            lastTick = nil
            return
        }
        let now = Date()
        defer { lastTick = now }
        guard let last = lastTick else { return }

        focused += now.timeIntervalSince(last)
        if focused >= day.seconds { end(completed: true) }
    }

    private func end(completed: Bool) {
        guard phase != .done else { return }
        phase = .done

        if completed {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        }

        store.finish(session: SessionRecord(
            date: .now,
            plannedSeconds: day.seconds,
            focusedSeconds: focused,
            completed: completed
        ))

        if !completed { dismiss() }
    }
}
