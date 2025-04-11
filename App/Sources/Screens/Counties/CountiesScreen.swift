import SwiftUI

struct CountiesScreen: View {

    @StateObject private var viewModel: CountiesViewModel

    init(params: CountiesParams) {
        _viewModel = StateObject(wrappedValue: CountiesViewModel(
            vehicle: params.vehicle,
            countyVignettes: params.countyVignettes
        ))
    }

    public var body: some View {
        VStack(spacing: 0.0) {
            ScrollView {
                CountiesView(counties: $viewModel.counties)
                    .padding(.all, 32.0)
            }
            TotalView(
                total: viewModel.total,
                nextEnabled: viewModel.nextEnabled
            ) {
                viewModel.nextClicked()
            }
        }
        .yettelToolbar()
        .background(YettelHomeworkAsset.Assets.surface.swiftUIColor)
    }
}

#Preview {
    CountiesScreen(
        vehicle: VehicleInfo(
            name: "John Doe",
            plate: "ABC-123"
        ),
        countyVignettes: []
    )
}
