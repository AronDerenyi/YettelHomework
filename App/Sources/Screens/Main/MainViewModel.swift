import Combine

@MainActor
class MainViewModel: ObservableObject {

    @Injected private var api: API
    @Injected private var navigator: Navigator
    @Injected private var errorHandler: ErrorHandler

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
        let highwayInfo = await errorHandler.handle {
            await api.getHighwayInfo()
        }

        let vehicleInfo = await errorHandler.handle {
            await api.getVehicleInfo()
        }

        if let highwayInfo = highwayInfo, let vehicleInfo = vehicleInfo {
            vehicle = vehicleInfo
            vignettes = highwayInfo.vignettes
            countyVignettes = highwayInfo.countyVignettes
        }
    }

    func purchaseClicked() {
        guard
            let vehicle,
            let vignettes,
            let selectedVignette,
            selectedVignette >= 0,
            selectedVignette < vignettes.count
        else {
            return
        }

        let vignette = vignettes[selectedVignette]
        navigator.push(.cart(.init(
            vehicle: vehicle,
            item: .vignette(vignette)
        )))
    }

    func countyVignettesClicked() {
        guard
            let vehicle,
            let countyVignettes
        else {
            return
        }

        navigator.push(.counties(.init(
            vehicle: vehicle,
            countyVignettes: countyVignettes
        )))
    }
}
