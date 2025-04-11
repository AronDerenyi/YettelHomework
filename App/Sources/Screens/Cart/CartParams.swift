struct CartParams: Equatable, Hashable {
    let vehicle: VehicleInfo
    let item: CartParamsItem
}

enum CartParamsItem: Equatable, Hashable {
    case vignette(Vignette)
    case countyVignettes([CountyVignette])
}
