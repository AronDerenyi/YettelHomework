public struct CartItem {
    
    public let cost: Float
    public let type: CartItemType

    public init(cost: Float, type: CartItemType) {
        self.cost = cost
        self.type = type
    }
}

public enum CartItemType {
    case country(type: VignetteType, category: String)
    case county(name: String)
}
