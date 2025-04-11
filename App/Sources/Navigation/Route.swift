import SwiftUI

enum Route: Equatable, Hashable {
    case counties(vehicle: VehicleInfo, countyVignettes: [CountyVignette])
    case cart
    case result
}

extension Route {
    var view: AnyView {
        switch self {
        case .counties(let vehicle, let countyVignettes):
            return AnyView(CountiesScreen(vehicle: vehicle, countyVignettes: countyVignettes))
        case .cart:
            return AnyView(CartScreen())
        case .result:
            return AnyView(ResultScreen())
        }
    }
}
