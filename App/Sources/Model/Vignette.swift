public struct Vignette: Equatable, Hashable {

    public let type: VignetteType
    public let cost: Float
    public let fee: Float
    public let category: String
    public let vehicleCategory: String

    public init(type: VignetteType, cost: Float, fee: Float, category: String, vehicleCategory: String) {
        self.type = type
        self.cost = cost
        self.fee = fee
        self.category = category
        self.vehicleCategory = vehicleCategory
    }
}
