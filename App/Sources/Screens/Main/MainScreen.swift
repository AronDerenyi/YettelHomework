import SwiftUI
import OpenAPIURLSession

public struct MainScreen: View {

    @StateObject private var viewModel = MainViewModel()

    public var body: some View {
        ScrollView {
            VStack {
                Loader(viewModel.vehicle) { vehicle in
                    HStack {
                        VStack {
                            Text(vehicle.name)
                            Text(vehicle.plate)
                        }
                    }
                } placeholder: {
                    Spacer().frame(maxWidth: .infinity).frame(height: 120.0)
                }
                .background(.blue)

                Loader(viewModel.vignettes) { vignettes in
                    Form {
                        
                    }
                } placeholder: {
                    Spacer().frame(height: 120.0)
                }

                Button {
                    viewModel.countyVignettesClicked()
                } label: {
                    HStack {
                        Text("main_buy_button")
                    }
                }
            }
        }
        .task {
            await viewModel.load()
        }
        .refreshable {
            await viewModel.load()
        }
    }
}

#Preview {
    MainScreen()
}
