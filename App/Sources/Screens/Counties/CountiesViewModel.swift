import Combine

@MainActor
public class CountiesViewModel: ObservableObject {

    @Injected private var navigator: Navigator

    private let vehicle: VehicleInfo
    private let countyVignettes: [CountyVignette]

    @Published public var counties: [County]
    public var total: Float {
        counties
            .lazy
            .filter(\.selected)
            .map(\.cost)
            .reduce(0.0, +)
    }
    public var nextEnabled: Bool {
        !counties
            .lazy
            .filter(\.selected)
            .isEmpty
    }

    public init(_ params: CountiesParams) {
        self.vehicle = params.vehicle
        self.countyVignettes = params.countyVignettes
        self.counties = params.countyVignettes.map { vignette in
            County(id: vignette.id, name: vignette.name, cost: vignette.cost, selected: false)
        }
    }

    public func nextClicked() {
        let selectedIds = Set(counties.lazy.filter(\.selected).map(\.id))
        let selectedVignettes = countyVignettes.filter { selectedIds.contains($0.id) }

        if !selectedVignettes.isEmpty {
            navigator.push(.cart(.init(
                vehicle: vehicle,
                item: .countyVignettes(selectedVignettes)
            )))
        }
    }
}
