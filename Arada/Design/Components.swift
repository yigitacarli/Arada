import SwiftUI

/// Tek ve sakin birincil eylem. Gölge, gradyan, yuvarlak köşe yok — sert kenar.
struct QuietButton: View {
    @Environment(\.palette) private var p
    let title: LocalizedStringKey
    var filled: Bool = true
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.serifText(15))
                .tracking(2.4)
                .textCase(.uppercase)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .foregroundStyle(filled ? p.wallHi : p.ink)
                .background(filled ? p.ink : Color.clear)
                .overlay(Rectangle().stroke(p.ink.opacity(0.34), lineWidth: filled ? 0 : 1))
        }
        .buttonStyle(.plain)
    }
}

/// Sekiz haftalık merdiven. Her satır bir hafta; çizginin uzunluğu o haftanın süresi.
/// Tamamlanan haftalar solgun mürekkep, bu hafta tam mürekkep, ileriki haftalar iz.
/// Bilerek renksiz — seri bozulma paniği yaratan hiçbir işaret yok.
struct ProgramLadder: View {
    @Environment(\.palette) private var p
    let completedDays: Int

    private var currentWeekIndex: Int { min(completedDays / 7, Program.weeklyMinutes.count - 1) }
    private let maxMinutes = CGFloat(Program.weeklyMinutes.max() ?? 22)

    var body: some View {
        VStack(alignment: .leading, spacing: 9) {
            RailLabel(text: "today.progressLabel")

            ForEach(Array(Program.weeklyMinutes.enumerated()), id: \.offset) { index, minutes in
                let done = (index + 1) * 7 <= completedDays
                let current = index == currentWeekIndex && !done
                let color: Color = current ? p.ink : (done ? p.ink.opacity(0.40) : p.ink.opacity(0.12))

                HStack(spacing: 12) {
                    Text(verbatim: "H\(index + 1)")
                        .font(.serifText(10))
                        .foregroundStyle(p.inkFaint)
                        .frame(width: 20, alignment: .leading)

                    GeometryReader { g in
                        ZStack(alignment: .leading) {
                            Rectangle().fill(p.ink.opacity(0.12)).frame(height: 2)
                            Rectangle().fill(color)
                                .frame(width: g.size.width * CGFloat(minutes) / maxMinutes, height: 2)
                        }
                        .frame(maxHeight: .infinity, alignment: .center)
                    }
                    .frame(height: 10)

                    Text(verbatim: "\(minutes)")
                        .font(.serifText(10))
                        .monospacedDigit()
                        .foregroundStyle(current ? p.ink : p.inkFaint)
                        .frame(width: 22, alignment: .trailing)
                }
            }
        }
    }
}

struct Hairline: View {
    @Environment(\.palette) private var p
    var body: some View {
        Rectangle().fill(p.ink.opacity(0.16)).frame(height: 1)
    }
}
