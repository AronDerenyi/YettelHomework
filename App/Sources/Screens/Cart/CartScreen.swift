import SwiftUI

struct CartScreen: View {

    @StateObject private var viewModel: CartViewModel

    init(params: CartParams) {
        _viewModel = StateObject(wrappedValue: .init(params))
    }

    public var body: some View {
        VStack(spacing: 0.0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0.0) {
                    YettelText(key: "cart_title", style: .title)
                        .padding(.vertical, 6.0)
                    YettelDivider()
                    CartDetailsView(
                        plate: viewModel.plate,
                        type: viewModel.type
                    )
                    YettelDivider()
                    CartItemsView(
                        items: viewModel.items,
                        fee: viewModel.fee
                    )
                }
                .padding(.horizontal, 32.0)
                .padding(.top, 16.0)
                .padding(.bottom, 32.0)
            }
            PayView(totel: viewModel.total) {
                viewModel.nextClicked()
            } cancel: {
                viewModel.cancelClicked()
            }
        }
        .yettelToolbar(showBackButton: true)
        .background(YettelHomeworkAsset.Assets.surface.swiftUIColor)
        .fullScreenCover(isPresented: $viewModel.showResult) {
            ResultView {
                viewModel.resultDismissed()
            }
        }
    }
}

#Preview {
    CartScreen(params: CartParams(vehicle: VehicleInfo(name: "", plate: ""), item: .countyVignettes([])))
}
