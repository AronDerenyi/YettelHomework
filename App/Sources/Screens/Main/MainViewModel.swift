import Combine

@MainActor
class MainViewModel: ObservableObject {

    @Injected private var navigator: Navigator
    @Injected private var api: API

    @Published var vehicle: VehicleInfo?

    @Published var vignettes: [Vignette]?
    @Published var selectedVignette: Int?

    var purchaseEnabled: Bool {
        guard let vignettes, let selectedVignette else {
            return false
        }

        return selectedVignette >= 0 && selectedVignette < vignettes.count
    }

    var countiesLoaded: Bool {
        countyVignettes != nil
    }

    @Published private var countyVignettes: [CountyVignette]?

    func load() async {
        let highwayInfo = await api.getHighwayInfo()
        let vehicleInfo = await api.getVehicleInfo()

        if
            case .success(let highwayInfo) = highwayInfo,
            case .success(let vehicleInfo) = vehicleInfo
        {
            vehicle = vehicleInfo
            vignettes = highwayInfo.vignettes
            selectedVignette = nil
            countyVignettes = highwayInfo.countyVignettes
        }
    }

    func purchaseClicked() {
        guard
            let vignettes,
            let selectedVignette,
            selectedVignette >= 0,
            selectedVignette < vignettes.count
        else {
            return
        }

        let vignette = vignettes[selectedVignette]
        navigator.push(.cart/*TODO: (vignette)*/)
    }

    func countyVignettesClicked() {
        guard
            let vehicle,
            let countyVignettes
        else {
            return
        }

        navigator.push(.counties(vehicle: vehicle, countyVignettes: countyVignettes))
    }
}
