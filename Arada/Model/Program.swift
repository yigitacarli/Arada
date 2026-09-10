import Foundation

/// Sekiz haftalık sıkılma antrenmanı.
/// Her hafta tek bir süre; hafta içinde süre sabit kalır, hafta değişince artar.
enum Program {
    /// Hafta başına oturum süresi (dakika).
    static let weeklyMinutes = [2, 4, 6, 9, 12, 15, 18, 22]
    static let daysPerWeek = 7
    static var totalDays: Int { weeklyMinutes.count * daysPerWeek }

    /// Tamamlanan gün sayısından bugünün oturumunu türetir.
    static func day(at completedDays: Int) -> Day {
        let clamped = min(completedDays, totalDays - 1)
        let week = clamped / daysPerWeek
        return Day(
            index: clamped,
            week: week + 1,
            dayOfWeek: clamped % daysPerWeek + 1,
            minutes: weeklyMinutes[week]
        )
    }

    struct Day {
        let index: Int
        let week: Int
        let dayOfWeek: Int
        let minutes: Int

        var seconds: TimeInterval { TimeInterval(minutes * 60) }
    }
}
