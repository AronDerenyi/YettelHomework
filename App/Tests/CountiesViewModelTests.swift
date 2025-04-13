import Foundation
import XCTest
import YettelHomework

final class CountiesViewModelTests: XCTestCase {

    @MainActor private func setup() -> (MockNavigator, CountiesViewModel) {
        let nevigator = MockNavigator()
        Injection.shared.register(Navigator.self) { nevigator }

        return (
            nevigator,
            CountiesViewModel(.init(
                vehicle: .init(name: "", plate: ""),
                countyVignettes: [
                    .init(id: "", name: "", cost: 0.0, fee: 0.0, vehicleCategory: "")
                ]
            ))
        )
    }

    @MainActor func test_noneSelected() {
        let (navigator, viewModel) = setup()
        XCTAssertEqual(viewModel.nextEnabled, false)

        viewModel.nextClicked()
        XCTAssertEqual(navigator.path, [])
    }

    @MainActor func test_firstSelected() {
        let (navigator, viewModel) = setup()
        XCTAssertEqual(viewModel.nextEnabled, false)

        viewModel.counties[0].selected = true
        XCTAssertEqual(viewModel.nextEnabled, true)

        viewModel.nextClicked()
        XCTAssertEqual(navigator.path, [.cart(.init(vehicle: .init(name: "", plate: ""), item: .countyVignettes([.init(id: "", name: "", cost: 0.0, fee: 0.0, vehicleCategory: "")])))])
    }
}

private class MockNavigator: Navigator {

    var path: [Route] = []

    func push(_ route: Route) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func clear() {
        path = []
    }
}
