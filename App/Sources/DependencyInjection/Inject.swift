import Swinject

func inject<Service>() -> Service {
    container.resolve(Service.self)!
}

fileprivate let container = {
    let container = Container()
    container.register(API.self) { _ in ClientAPI() }.inObjectScope(.container)
    container.register(Navigator.self) { _ in Navigator() }.inObjectScope(.container)
    return container
}()
