public protocol Navigator {
    func push(_ route: Route)
    func pop()
    func clear()
}
