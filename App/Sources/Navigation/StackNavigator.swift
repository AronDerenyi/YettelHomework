import SwiftUI

class StackNavigator: ObservableObject, Navigator {

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
    func navigation(_ navigator: StackNavigator) -> some View {
        modifier(StackNavigationModifier(navigator: navigator))
    }
}

private struct StackNavigationModifier: ViewModifier {

    @StateObject var navigator: StackNavigator

    func body(content: Content) -> some View {
        NavigationStack(path: $navigator.path) {
            content.navigationDestination(for: Route.self) { route in
                route.view
            }
        }
    }
}
