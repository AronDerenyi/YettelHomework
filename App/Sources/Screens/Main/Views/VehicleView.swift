import SwiftUI

struct VehicleView: View {

    let vehicle: VehicleInfo

    var body: some View {
        HStack(spacing: 16.0) {
            YettelHomeworkAsset.Assets.car.swiftUIImage
            VStack(alignment: .leading, spacing: 4.0) {
                YettelText(vehicle.name)
                YettelText(vehicle.plate, style: .tiny)
            }
            .padding(.vertical, 6.0)
            Spacer()
        }
        .padding(.all, 16.0)
    }
}
