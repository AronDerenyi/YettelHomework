import Combine

@MainActor
class CountiesViewModel: ObservableObject {

    @Injected private var navigator: Navigator

    private let vehicle: VehicleInfo
    private let countyVignettes: [CountyVignette]

    @Published var counties: [County]
    var total: Float {
        counties
            .lazy
            .filter(\.selected)
            .map(\.cost)
            .reduce(0.0, +)
    }
    var nextEnabled: Bool {
        !counties
            .lazy
            .filter(\.selected)
            .isEmpty
    }

    init(vehicle: VehicleInfo, countyVignettes: [CountyVignette]) {
        self.vehicle = vehicle
        self.countyVignettes = countyVignettes
        self.counties = countyVignettes.map { vignette in
            County(id: vignette.id, name: vignette.name, cost: vignette.cost, selected: false)
        }
    }

    func nextClicked() {
        let selectedIds = Set(counties.lazy.filter(\.selected).map(\.id))
        let selectedVignettes = countyVignettes.filter { selectedIds.contains($0.id) }

        if !selectedVignettes.isEmpty {
            navigator.push(.cart)
        }
    }
}
