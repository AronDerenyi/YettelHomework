import Combine

class CartViewModel: ObservableObject {

    let plate: String
    let type: CartType

    let items: [CartItem]
    let fee: Float

    let total: Float

    @Published var showResult: Bool = false

    @Injected private var navigator: Navigator
    @Injected private var api: API

    private let params: CartParams

    init(_ params: CartParams) {
        self.params = params
        switch params.item {
        case .vignette(let vignette):
            plate = params.vehicle.plate
            type = .country(type: vignette.type)
            items = [CartItem(cost: vignette.cost, type: .country(type: vignette.type, category: vignette.category))]
            fee = vignette.fee
            total = vignette.cost + vignette.fee
        case .countyVignettes(let countyVignettes):
            plate = params.vehicle.plate
            type = .county
            items = countyVignettes.map { .init(cost: $0.cost, type: .county(name: $0.name)) }
            fee = countyVignettes.map(\.fee).reduce(0.0, +)
            total = countyVignettes.map(\.cost).reduce(0.0, +) + fee
        }
    }

    func nextClicked() {
        Task {
            let result: Result<(), PostError>
            switch params.item {
            case .vignette(let vignette):
                result = await api.postHighwayOrder(vignette: vignette)
            case .countyVignettes(let countyVignettes):
                result = await api.postHighwayOrder(countyVignettes: countyVignettes)
            }

            switch result {
            case .success:
                await MainActor.run {
                    showResult = true
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func cancelClicked() {
        navigator.pop()
    }

    func resultDismissed() {
        if showResult {
            navigator.clear()
            showResult = false
        }
    }
}
