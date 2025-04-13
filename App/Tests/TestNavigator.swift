import YettelHomework

class TestNavigator: Navigator {

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
