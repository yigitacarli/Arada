import SwiftUI
import AudioToolbox
import UIKit

struct SessionView: View {
    let day: Program.Day

    @EnvironmentObject private var store: Store
    @Environment(\.dismiss) private var dismiss
    @StateObject private var motion = FaceDownMonitor()

    @State private var focused: TimeInterval = 0
    @State private var lastTick: Date?
    @State private var phase: Phase = .waiting

    private enum Phase { case waiting, running, done }

    private let tick = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            // Oturum sırasında ekran siyaha düşüyor: telefon yüzüstü duruyor,
            // bakılacak bir şey yok ve OLED ekran boşa yanmıyor.
            (phase == .running ? Color.black : Color.aradaPaper)
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.6), value: phase)

            VStack(spacing: 0) {
                Spacer()
                content
                Spacer()
                footer
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
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
            VStack(spacing: 18) {
                Text("session.turnOver")
                    .font(.aradaDisplay(27, weight: .light))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.aradaInk)
                Text("session.turnOverBody")
                    .font(.aradaBody)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.aradaInk2)
            }

        case .running:
            VStack(spacing: 20) {
                Text(remainingText)
                    .font(.aradaNumeral(64))
                    .foregroundStyle(Color.white.opacity(motion.isFaceDown ? 0.10 : 0.55))
                if !motion.isFaceDown {
                    Text("session.paused")
                        .font(.aradaBody)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.white.opacity(0.45))
                }
            }
            .animation(.easeInOut(duration: 0.5), value: motion.isFaceDown)

        case .done:
            VStack(spacing: 18) {
                Text("session.done")
                    .font(.aradaDisplay(30, weight: .light))
                    .foregroundStyle(Color.aradaInk)
                Text("session.doneBody \(day.minutes)")
                    .font(.aradaBody)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.aradaInk2)
            }
        }
    }

    @ViewBuilder
    private var footer: some View {
        switch phase {
        case .waiting:
            QuietButton(title: "session.cancel", filled: false) { dismiss() }
        case .running:
            // Vazgeçme düğmesi telefon yüzüstüyken tamamen kayboluyor;
            // ancak telefonu eline aldığında geri geliyor.
            Button("session.giveUp") { end(completed: false) }
                .font(.aradaSmall)
                .foregroundStyle(Color.white.opacity(motion.isFaceDown ? 0.0 : 0.35))
                .animation(.easeInOut(duration: 0.5), value: motion.isFaceDown)
        case .done:
            QuietButton(title: "session.close") { dismiss() }
        }
    }

    private var remainingText: String {
        let left = max(0, day.seconds - focused)
        return String(format: "%d:%02d", Int(left) / 60, Int(left) % 60)
    }

    private func advance() {
        guard phase == .running else { return }
        guard motion.isFaceDown else {
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
