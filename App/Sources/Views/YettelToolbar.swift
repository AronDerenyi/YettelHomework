import SwiftUI

extension View {
    func yettelToolbar() -> some View {
        self
            .toolbarBackgroundVisibility(.visible)
            .navigationTitle("E-matrica")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(YettelHomeworkAsset.Assets.accent.swiftUIColor)
    }
}
