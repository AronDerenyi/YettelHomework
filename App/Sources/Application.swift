import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

@main
struct Application: App {

    private let navigator = StackNavigator()
    private let errorHandler = AlertErrorHandler()

    init() {
        Injection.shared.register(API.self) { ClientAPI() }
        Injection.shared.register(Navigator.self) { [self] in navigator }
        Injection.shared.register(ErrorHandler.self) { [self] in errorHandler }
    }

    var body: some Scene {
        WindowGroup {
            MainScreen()
                .navigation(navigator)
                .errorHandling(errorHandler)
        }
    }
}
