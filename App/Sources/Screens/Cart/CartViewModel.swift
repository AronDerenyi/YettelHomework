import Combine

@MainActor
public class CartViewModel: ObservableObject {

    public let plate: String
    public let type: CartType

    public let items: [CartItem]
    public let fee: Float

    public let total: Float

    @Published public var showResult: Bool = false

    @Injected private var api: API
    @Injected private var navigator: Navigator
    @Injected private var errorHandler: ErrorHandler

    private let params: CartParams

    public init(_ params: CartParams) {
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

    public func nextClicked() {
        Task {
            let result: ()? = await errorHandler.handle {
                switch params.item {
                case .vignette(let vignette):
                    await api.postHighwayOrder(vignette: vignette)
                case .countyVignettes(let countyVignettes):
                    await api.postHighwayOrder(countyVignettes: countyVignettes)
                }
            }

            if result != nil {
                await MainActor.run {
                    showResult = true
                }
            }
        }
    }

    public func cancelClicked() {
        navigator.pop()
    }

    public func resultDismissed() {
        if showResult {
            navigator.clear()
            showResult = false
        }
    }
}
