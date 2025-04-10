protocol API {
    func getHighwayInfo() async -> Result<HighwayInfo, GetError>
    func getVehicleInfo() async -> Result<VehicleInfo, GetError>
    func postHighwayOrder() async -> Result<(), PostError>
}
