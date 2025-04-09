import SwiftUI

enum Route {
    case counties
    case cart
    case result
}

extension Route {
    var view: AnyView {
        switch self {
        case .counties:
            return AnyView(CountiesScreen())
        case .cart:
            return AnyView(CartScreen())
        case .result:
            return AnyView(ResultScreen())
        }
    }
}
