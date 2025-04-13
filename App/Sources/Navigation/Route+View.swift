import SwiftUI

extension Route {
    @ViewBuilder var view: some View {
        switch self {
        case .counties(let params):
            CountiesScreen(params: params)
        case .cart(let params):
            CartScreen(params: params)
        }
    }
}
