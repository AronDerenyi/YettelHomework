import Swinject

public final class Injection {

    public static let shared = Injection()

    private let container: Container = Container()

    private init() {

    }

    public func register<Service>(
        _ serviceType: Service.Type,
        factory: @escaping (Resolver) -> Service
    ) {
        container
            .register(serviceType, factory: factory)
            .inObjectScope(.container)
    }

    public func register<Service>(
        _ serviceType: Service.Type,
        factory: @escaping () -> Service
    ) {
        container
            .register(serviceType) { _ in factory() }
            .inObjectScope(.container)
    }

    public func inject<Service>() -> Service {
        container.resolve(Service.self)!
    }
}
