public protocol API {
    func getHighwayInfo() async -> Result<HighwayInfo, GetError>
    func getVehicleInfo() async -> Result<VehicleInfo, GetError>
    func postHighwayOrder(vignette: Vignette) async -> Result<(), PostError>
    func postHighwayOrder(countyVignettes: [CountyVignette]) async -> Result<(), PostError>
}
