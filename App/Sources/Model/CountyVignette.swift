public struct CountyVignette: Equatable, Hashable {
    
    public let id: String
    public let name: String
    public let cost: Float
    public let fee: Float
    public let vehicleCategory: String

    public init(id: String, name: String, cost: Float, fee: Float, vehicleCategory: String) {
        self.id = id
        self.name = name
        self.cost = cost
        self.fee = fee
        self.vehicleCategory = vehicleCategory
    }
}
