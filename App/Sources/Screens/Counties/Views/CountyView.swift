import SwiftUI

struct CountyView: View {

    @Binding var county: County

    var body: some View {
        HStack(spacing: 12.0) {
            if county.selected {
                YettelHomeworkAsset.Assets.checkboxOn.swiftUIImage
            } else {
                YettelHomeworkAsset.Assets.checkboxOff.swiftUIImage
            }

            YettelText(county.name, style: county.selected ? .light : .thin)
                .frame(maxWidth: .infinity, alignment: .leading)

            YettelText(NSNumber(value: county.cost), format: .currency, style: .bold)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            county.selected.toggle()
        }
    }
}
