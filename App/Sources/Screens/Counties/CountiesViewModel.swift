import Combine

@MainActor
public class CountiesViewModel: ObservableObject {

    @Injected private var navigator: Navigator

    private let vehicle: VehicleInfo
    private let countyVignettes: [CountyVignette]

    @Published public var counties: [County] {
        didSet {
            let prevSelected = Set(oldValue.filter(\.selected).map(\.id))
            let selected = Set(counties.filter(\.selected).map(\.id))
            checkNeighbors(prevSelected: prevSelected, selected: selected)
        }
    }
    @Published public var showNeighborAlert: Bool = false

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
            County(id: vignette.id, name: vignette.name, cost: vignette.cost, selected: false, isolated: false)
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

    private func checkNeighbors(prevSelected: Set<String>, selected: Set<String>) {
        var newSelected = selected.subtracting(prevSelected)
        let newUnselected = prevSelected.subtracting(selected)
        guard !prevSelected.isEmpty, !newSelected.isEmpty || !newUnselected.isEmpty else {
            return
        }

        var neighboringCounties = Set(prevSelected.flatMap { COUNTY_NEIGHBORS[$0] ?? [] })
        while !newSelected.isEmpty {
            let intersection = newSelected.intersection(neighboringCounties)

            if !intersection.isEmpty {
                newSelected.subtract(intersection)
                neighboringCounties.formUnion(intersection.flatMap { COUNTY_NEIGHBORS[$0] ?? [] })
            } else {
                showNeighborAlert = true
                break
            }
        }

        counties = counties.map { county in
            var county = county
            county.isolated = newSelected.contains(county.id)
            return county
        }
    }
}

private let COUNTY_NEIGHBORS: [String: Set<String>] = [
    "YEAR_11": ["YEAR_12", "YEAR_26", "YEAR_16", "YEAR_23", "YEAR_20", "YEAR_15"],
    "YEAR_12": ["YEAR_24", "YEAR_26", "YEAR_11"],
    "YEAR_13": ["YEAR_15", "YEAR_20", "YEAR_18"],
    "YEAR_14": ["YEAR_25", "YEAR_18", "YEAR_20", "YEAR_19", "YEAR_22"],
    "YEAR_15": ["YEAR_13", "YEAR_20", "YEAR_11"],
    "YEAR_16": ["YEAR_23", "YEAR_11", "YEAR_26", "YEAR_24", "YEAR_28", "YEAR_21"],
    "YEAR_17": ["YEAR_21", "YEAR_28", "YEAR_27"],
    "YEAR_18": ["YEAR_25", "YEAR_14", "YEAR_20", "YEAR_13"],
    "YEAR_19": ["YEAR_14", "YEAR_20", "YEAR_23", "YEAR_22"],
    "YEAR_20": ["YEAR_19", "YEAR_14", "YEAR_18", "YEAR_13", "YEAR_15", "YEAR_11", "YEAR_23"],
    "YEAR_21": ["YEAR_23", "YEAR_16", "YEAR_28", "YEAR_17"],
    "YEAR_22": ["YEAR_23", "YEAR_19", "YEAR_14"],
    "YEAR_23": ["YEAR_22", "YEAR_19", "YEAR_20", "YEAR_11", "YEAR_16", "YEAR_21"],
    "YEAR_24": ["YEAR_12", "YEAR_26", "YEAR_16", "YEAR_28", "YEAR_29"],
    "YEAR_25": ["YEAR_18", "YEAR_14"],
    "YEAR_26": ["YEAR_16", "YEAR_11", "YEAR_12", "YEAR_24"],
    "YEAR_27": ["YEAR_17", "YEAR_28", "YEAR_29"],
    "YEAR_28": ["YEAR_17", "YEAR_21", "YEAR_16", "YEAR_24", "YEAR_29", "YEAR_27"],
    "YEAR_29": ["YEAR_27", "YEAR_28", "YEAR_24"],
]
