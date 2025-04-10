import Combine

@MainActor
class MainViewModel: ObservableObject {

    @Injected private var navigator: Navigator
    @Injected private var api: API

    @Published var vehicle: VehicleInfo?
    @Published var vignettes: [Vignette]?

    func load() async {
        let highwayInfo = await api.getHighwayInfo()
        let vehicleInfo = await api.getVehicleInfo()

        if
            case .success(let highwayInfo) = highwayInfo,
            case .success(let vehicleInfo) = vehicleInfo
        {
            vehicle = vehicleInfo
            vignettes = highwayInfo.vignettes
        }
    }

    func countyVignettesClicked() {
        navigator.push(.counties)
    }
}
