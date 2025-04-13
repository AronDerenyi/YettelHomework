import Swinject

fileprivate var container: Container = Container()

func register<Service>(
    _ serviceType: Service.Type,
    factory: @escaping (Resolver) -> Service
) {
    container
        .register(serviceType, factory: factory)
        .inObjectScope(.container)
}

func register<Service>(
    _ serviceType: Service.Type,
    factory: @escaping () -> Service
) {
    container
        .register(serviceType) { _ in factory() }
        .inObjectScope(.container)
}

func inject<Service>() -> Service {
    container.resolve(Service.self)!
}
