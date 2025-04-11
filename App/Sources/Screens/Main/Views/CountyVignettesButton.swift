import SwiftUI

struct CountyVignettesButton: View {

    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                YettelText(key: "main_county_vignettes_button", style: .title)
                    .padding(.vertical, 6.0)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(YettelHomeworkAsset.Assets.primary.swiftUIColor)
            }
            .padding(16.0)
            .background(YettelHomeworkAsset.Assets.surface.swiftUIColor)
            .cornerRadius(16.0)
        }
    }
}
