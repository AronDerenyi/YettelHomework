import SwiftUI

struct CountiesScreen: View {

    @StateObject private var viewModel: CountiesViewModel

    init(params: CountiesParams) {
        _viewModel = StateObject(wrappedValue: .init(params))
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
        .yettelToolbar(showBackButton: true)
        .background(YettelHomeworkAsset.Assets.surface.swiftUIColor)
    }
}

#Preview {
    CountiesScreen(params: CountiesParams(
        vehicle: VehicleInfo(
            name: "John Doe",
            plate: "ABC-123"
        ),
        countyVignettes: []
    ))
}
