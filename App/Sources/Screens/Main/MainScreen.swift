import SwiftUI
import OpenAPIURLSession

public struct MainScreen: View {

    @StateObject private var viewModel = MainViewModel()

    public var body: some View {
        ScrollView {
            VStack {
                Loader(viewModel.vehicle) { vehicle in
                    VehicleView(vehicle: vehicle)
                } placeholder: {
                    Spacer()
                        .frame(maxWidth: .infinity)
                        .frame(height: 72.0)
                }
                .background(YettelHomeworkAsset.Assets.surface.swiftUIColor)
                .cornerRadius(16.0)

                Loader(viewModel.vignettes) { vignettes in
                    VignettesView(
                        vignettes: vignettes,
                        selected: $viewModel.selectedVignette,
                        purchaseEnabled: viewModel.purchaseEnabled
                    ) {
                        viewModel.purchaseClicked()
                    }
                } placeholder: {
                    Spacer()
                        .frame(maxWidth: .infinity)
                        .frame(height: 300.0)
                }
                .background(YettelHomeworkAsset.Assets.surface.swiftUIColor)
                .cornerRadius(16.0)

                if viewModel.countiesLoaded {
                    CountyVignettesButton {
                        viewModel.countyVignettesClicked()
                    }
                }
            }
            .padding(.all, 16.0)
        }
        .yettelToolbar()
        .background(YettelHomeworkAsset.Assets.background.swiftUIColor)
        .task {
            await viewModel.load()
        }
        .refreshable {
            await viewModel.load()
        }
    }
}

#Preview {
    NavigationStack {
        MainScreen()
    }
}
