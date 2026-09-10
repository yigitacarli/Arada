import SwiftUI

/// Tek ve sakin birincil eylem. Gölge, gradyan, parlama yok — sadece kenarlık.
struct QuietButton: View {
    let title: LocalizedStringKey
    var filled: Bool = true
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .medium))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 17)
                .foregroundStyle(filled ? Color.aradaPaper : Color.aradaInk)
                .background(filled ? Color.aradaInk : Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.aradaRule, lineWidth: filled ? 0 : 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 2))
        }
        .buttonStyle(.plain)
    }
}

/// 8 hafta × 7 gün. Tamamlanan gün dolu, bugün çerçeveli, gerisi boş.
/// Bilerek renksiz: seri bozulma paniği yaratan hiçbir işaret yok.
struct ProgramGrid: View {
    let completedDays: Int
    let totalDays: Int

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 6), count: 7)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 6) {
            ForEach(0..<totalDays, id: \.self) { index in
                RoundedRectangle(cornerRadius: 1)
                    .fill(index < completedDays ? Color.aradaAccent : Color.aradaPaper2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 1)
                            .stroke(Color.aradaInk2, lineWidth: index == completedDays ? 1 : 0)
                    )
                    .aspectRatio(1, contentMode: .fit)
            }
        }
    }
}

struct Divider1: View {
    var body: some View {
        Rectangle()
            .fill(Color.aradaRule)
            .frame(height: 1)
    }
}
