import SwiftUI

struct MapView: View {

    let counties: [County]

    var body: some View {
        ZStack {
            YettelHomeworkAsset.Assets.country.swiftUIImage
                .resizable()
                .aspectRatio(contentMode: .fit)

            ForEach(counties, id: \.id) { county in
                if county.selected {
                    let image = COUNTY_IMAGES[county.id]?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(
                            county.isolated ?
                            YettelHomeworkAsset.Assets.primary.swiftUIColor :
                            YettelHomeworkAsset.Assets.accent.swiftUIColor
                        )

                    if county.isolated {
                        image.foregroundStyle(.red)
                    } else {
                        image
                    }
                }
            }
        }
    }
}

private let COUNTY_IMAGES = [
    "YEAR_11": YettelHomeworkAsset.Assets.county11.swiftUIImage,
    "YEAR_12": YettelHomeworkAsset.Assets.county12.swiftUIImage,
    "YEAR_13": YettelHomeworkAsset.Assets.county13.swiftUIImage,
    "YEAR_14": YettelHomeworkAsset.Assets.county14.swiftUIImage,
    "YEAR_15": YettelHomeworkAsset.Assets.county15.swiftUIImage,
    "YEAR_16": YettelHomeworkAsset.Assets.county16.swiftUIImage,
    "YEAR_17": YettelHomeworkAsset.Assets.county17.swiftUIImage,
    "YEAR_18": YettelHomeworkAsset.Assets.county18.swiftUIImage,
    "YEAR_19": YettelHomeworkAsset.Assets.county19.swiftUIImage,
    "YEAR_20": YettelHomeworkAsset.Assets.county20.swiftUIImage,
    "YEAR_21": YettelHomeworkAsset.Assets.county21.swiftUIImage,
    "YEAR_22": YettelHomeworkAsset.Assets.county22.swiftUIImage,
    "YEAR_23": YettelHomeworkAsset.Assets.county23.swiftUIImage,
    "YEAR_24": YettelHomeworkAsset.Assets.county24.swiftUIImage,
    "YEAR_25": YettelHomeworkAsset.Assets.county25.swiftUIImage,
    "YEAR_26": YettelHomeworkAsset.Assets.county26.swiftUIImage,
    "YEAR_27": YettelHomeworkAsset.Assets.county27.swiftUIImage,
    "YEAR_28": YettelHomeworkAsset.Assets.county28.swiftUIImage,
    "YEAR_29": YettelHomeworkAsset.Assets.county29.swiftUIImage,
]
