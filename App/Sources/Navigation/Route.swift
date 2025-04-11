import SwiftUI

enum Route: Equatable, Hashable {
    case counties(CountiesParams)
    case cart(CartParams)
}

extension Route {
    var view: AnyView {
        switch self {
        case .counties(let params):
            return AnyView(CountiesScreen(params: params))
        case .cart(let params):
            return AnyView(CartScreen(params: params))
        }
    }
}
