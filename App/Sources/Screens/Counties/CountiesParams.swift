public struct CountiesParams: Equatable, Hashable {

    public let vehicle: VehicleInfo
    public let countyVignettes: [CountyVignette]

    public init(vehicle: VehicleInfo, countyVignettes: [CountyVignette]) {
        self.vehicle = vehicle
        self.countyVignettes = countyVignettes
    }
}
