import Foundation
import SwiftUI

struct SessionRecord: Codable, Identifiable {
    var id = UUID()
    var date: Date
    var plannedSeconds: TimeInterval
    var focusedSeconds: TimeInterval
    var completed: Bool
}

struct AradaState: Codable {
    var completedDays: Int = 0
    var lastSessionDay: Date?
    var log: [SessionRecord] = []
}

/// Sunucu yok, hesap yok. Durum cihazda tek bir JSON dosyasında duruyor.
@MainActor
final class Store: ObservableObject {
    @Published private(set) var state = AradaState()

    private let url: URL = {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir.appendingPathComponent("arada-state.json")
    }()

    init() {
        load()
        applyMissedDayRule()
    }

    var today: Program.Day { Program.day(at: state.completedDays) }

    var isFinished: Bool { state.completedDays >= Program.totalDays }

    var didSessionToday: Bool {
        guard let last = state.lastSessionDay else { return false }
        return Calendar.current.isDateInToday(last)
    }

    /// Bu hafta ve toplamda kasıtlı olarak sıkılarak geçirilen süre.
    var totalFocusedSeconds: TimeInterval {
        state.log.reduce(0) { $0 + $1.focusedSeconds }
    }

    func finish(session record: SessionRecord) {
        state.log.append(record)
        if record.completed && !didSessionToday {
            state.completedDays = min(state.completedDays + 1, Program.totalDays)
            state.lastSessionDay = record.date
        }
        save()
    }

    /// Plandaki kural: kaçırılan gün programı sıfırlamaz, bir basamak geri alır.
    /// Ceza değil, kalibrasyon — kapasite kullanılmadığında geriliyor.
    private func applyMissedDayRule() {
        guard let last = state.lastSessionDay else { return }
        let cal = Calendar.current
        let days = cal.dateComponents([.day], from: cal.startOfDay(for: last), to: cal.startOfDay(for: .now)).day ?? 0
        if days >= 2 {
            state.completedDays = max(0, state.completedDays - 1)
            state.lastSessionDay = cal.date(byAdding: .day, value: -1, to: .now)
            save()
        }
    }

    private func load() {
        guard let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode(AradaState.self, from: data) else { return }
        state = decoded
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(state) else { return }
        try? data.write(to: url, options: .atomic)
    }
}
