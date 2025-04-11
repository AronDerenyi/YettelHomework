struct CartItem {
    let cost: Float
    let type: CartItemType
}

enum CartItemType {
    case country(type: VignetteType, category: String)
    case county(name: String)
}
