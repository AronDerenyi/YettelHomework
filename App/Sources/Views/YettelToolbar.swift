import SwiftUI

extension View {
    func yettelToolbar(showBackButton: Bool = false) -> some View {
        modifier(YettelToolbarModifier(showBackButton: showBackButton))
    }
}

struct YettelToolbarModifier: ViewModifier {

    let showBackButton: Bool
    @Environment(\.dismiss) var dismiss

    func body(content: Content) -> some View {
        VStack(spacing: 0.0) {
            HStack(spacing: 8.0) {
                if showBackButton {
                    Button {
                        dismiss()
                    } label: {
                        YettelHomeworkAsset.Assets.back.swiftUIImage
                    }
                }
                YettelText(key: "title", style: .bold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 32.0)
            .padding(.vertical, 16.0)
            .background(
                UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 20.0, bottomTrailing: 20.0))
                    .fill(YettelHomeworkAsset.Assets.accent.swiftUIColor)
                    .ignoresSafeArea()
            )
            content
        }
        .toolbar(.hidden)
    }
}
