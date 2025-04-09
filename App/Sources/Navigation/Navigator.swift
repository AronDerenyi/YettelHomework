import SwiftUI

class Navigator: ObservableObject {

    @Published fileprivate var path = NavigationPath()

    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        path.removeLast()
    }

    func clear() {
        path = NavigationPath()
    }
}

extension View {
    func navigator(_ navigator: Navigator) -> some View {
        modifier(NavigatorModifier(navigator: navigator))
    }
}

private struct NavigatorModifier: ViewModifier {

    @StateObject var navigator: Navigator

    func body(content: Content) -> some View {
        NavigationStack(path: $navigator.path) {
            content.navigationDestination(for: Route.self) { route in
                route.view
            }
        }
    }
}
