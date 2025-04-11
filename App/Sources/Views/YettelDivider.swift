import SwiftUI

struct YettelDivider: View {

    var body: some View {
        Divider()
            .frame(height: 1.0)
            .overlay(YettelHomeworkAsset.Assets.border.swiftUIColor)
    }
}
