public struct CartParams: Equatable, Hashable {
    public let vehicle: VehicleInfo
    public let item: CartParamsItem

    public init(vehicle: VehicleInfo, item: CartParamsItem) {
        self.vehicle = vehicle
        self.item = item
    }
}

public enum CartParamsItem: Equatable, Hashable {
    case vignette(Vignette)
    case countyVignettes([CountyVignette])
}
