import Foundation
import XCTest
import YettelHomework

@MainActor
final class CountiesViewModelTests: XCTestCase {

    private func setup() -> (TestNavigator, CountiesViewModel) {
        let nevigator = TestNavigator()
        Injection.shared.register(Navigator.self) { nevigator }

        return (
            nevigator,
            CountiesViewModel(.init(
                vehicle: VEHICLE_INFO,
                countyVignettes: COUNTY_VIGNETTES
            ))
        )
    }

    func test_noneSelected() {
        let (navigator, viewModel) = setup()

        // Check displayed data
        XCTAssertEqual(viewModel.total, 0.0)
        XCTAssertEqual(viewModel.nextEnabled, false)

        // Check navigation
        viewModel.nextClicked()
        XCTAssertEqual(navigator.path, [])
    }

    func test_firstSelected() {
        let (navigator, viewModel) = setup()

        // Select first
        viewModel.counties[0].selected = true

        // Check displayed data
        XCTAssertEqual(viewModel.total, COUNTY_VIGNETTES[0].cost)
        XCTAssertEqual(viewModel.nextEnabled, true)

        // Check navigation
        viewModel.nextClicked()
        XCTAssertEqual(navigator.path, [.cart(.init(
            vehicle: VEHICLE_INFO,
            item: .countyVignettes(Array(COUNTY_VIGNETTES[0..<1]))
        ))])
    }

    func test_firstFiveSelected() {
        let (navigator, viewModel) = setup()

        // Select first five
        for i in 0..<5 {
            viewModel.counties[i].selected = true
        }

        // Check displayed data
        XCTAssertEqual(viewModel.total, COUNTY_VIGNETTES[0..<5].map(\.cost).reduce(0.0, +))
        XCTAssertEqual(viewModel.nextEnabled, true)

        // Check navigation
        viewModel.nextClicked()
        XCTAssertEqual(navigator.path, [.cart(.init(
            vehicle: VEHICLE_INFO,
            item: .countyVignettes(Array(COUNTY_VIGNETTES[0..<5]))
        ))])
    }

    func test_firstSelectedAndUnselected() {
        let (navigator, viewModel) = setup()

        // Select first
        viewModel.counties[0].selected = true

        // Check displayed data
        XCTAssertEqual(viewModel.total, COUNTY_VIGNETTES[0].cost)
        XCTAssertEqual(viewModel.nextEnabled, true)

        // Unselect first
        viewModel.counties[0].selected = false

        // Check displayed data
        XCTAssertEqual(viewModel.total, 0.0)
        XCTAssertEqual(viewModel.nextEnabled, false)

        // Check navigation
        viewModel.nextClicked()
        XCTAssertEqual(navigator.path, [])
    }
}
