import FamilyControls
import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var screenTime: ScreenTimeService
    @Environment(\.scenePhase) private var scenePhase
    @State private var showsPicker = false

    var body: some View {
        NavigationStack {
            ZStack {
                AradaTheme.paper.ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        header
                        Spacer(minLength: 58)
                        pauseMark
                        Spacer(minLength: 42)
                        status
                        Spacer(minLength: 28)
                        controls
                    }
                    .padding(.horizontal, 28)
                    .padding(.bottom, 32)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .familyActivityPicker(isPresented: $showsPicker, selection: $screenTime.selection)
            .onChange(of: showsPicker) { _, isPresented in
                if !isPresented { screenTime.saveSelection() }
            }
            .onChange(of: scenePhase) { _, phase in
                if phase == .active { screenTime.refresh() }
            }
        }
        .tint(AradaTheme.olive)
    }

    private var header: some View {
        HStack {
            Text("ARADA")
                .font(.system(.headline, design: .serif, weight: .medium))
                .tracking(4)
            Spacer()
            Text("TEKNİK DENEME")
                .font(.caption.weight(.medium))
                .foregroundStyle(AradaTheme.quiet)
        }
        .padding(.top, 20)
    }

    private var pauseMark: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("KENDİNE BİR ARA")
                .font(.caption.weight(.semibold))
                .tracking(2)
                .foregroundStyle(AradaTheme.olive)
            Text("Biraz\nalan aç.")
                .font(.system(size: 58, weight: .regular, design: .serif))
                .minimumScaleFactor(0.72)
                .foregroundStyle(AradaTheme.ink)
                .accessibilityAddTraits(.isHeader)
            HStack(spacing: 38) {
                Capsule().fill(AradaTheme.olive).frame(width: 36, height: 76)
                Capsule().fill(AradaTheme.olive.opacity(0.55)).frame(width: 36, height: 76)
            }
            .frame(maxWidth: .infinity)
            .accessibilityHidden(true)
        }
    }

    @ViewBuilder
    private var status: some View {
        switch screenTime.protectionState {
        case .inactive:
            Text("Seçtiğin uygulamalarla arana 15 dakikalık bir mesafe koy.")
        case .starting:
            Text("Koruma hazırlanıyor…")
        case let .active(until):
            VStack(alignment: .leading, spacing: 6) {
                Text("Koruma açık")
                    .font(.headline)
                Text(until, style: .relative)
                    .foregroundStyle(AradaTheme.quiet)
                if let message = screenTime.liveActivityMessage {
                    Text(message)
                        .font(.caption)
                        .foregroundStyle(AradaTheme.quiet)
                }
            }
        case .stopping:
            Text("Koruma kaldırılıyor…")
        case let .failed(message):
            Text(message).foregroundStyle(Color.red)
        }
    }

    private var controls: some View {
        VStack(spacing: 12) {
            if screenTime.authorizationStatus != .approved {
                Button("Screen Time izni ver") {
                    Task { await screenTime.requestAuthorization() }
                }
                .buttonStyle(PrimaryAradaButtonStyle())
            }

            Button {
                showsPicker = true
            } label: {
                HStack {
                    Text("Korunacakları seç")
                    Spacer()
                    Text(screenTime.selectionSummary)
                        .foregroundStyle(AradaTheme.quiet)
                        .lineLimit(1)
                }
            }
            .buttonStyle(QuietAradaButtonStyle())

            if screenTime.protectionState.isActive {
                Button("Korumayı bitir") { screenTime.stopProtection() }
                    .buttonStyle(PrimaryAradaButtonStyle())
            } else {
                Button("15 dakikalık ara başlat") { screenTime.startProtection() }
                    .buttonStyle(PrimaryAradaButtonStyle())
                    .disabled(!screenTime.canStartProtection)
            }
        }
    }
}

private struct PrimaryAradaButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.weight(.semibold))
            .frame(maxWidth: .infinity, minHeight: 54)
            .foregroundStyle(AradaTheme.paper)
            .background(AradaTheme.olive.opacity(configuration.isPressed ? 0.75 : 1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

private struct QuietAradaButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.weight(.medium))
            .frame(maxWidth: .infinity, minHeight: 52)
            .foregroundStyle(AradaTheme.ink)
            .padding(.horizontal, 2)
            .overlay(alignment: .bottom) {
                Rectangle().fill(AradaTheme.line).frame(height: 1)
            }
            .opacity(configuration.isPressed ? 0.6 : 1)
    }
}
