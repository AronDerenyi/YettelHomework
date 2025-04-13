import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

@main
struct Application: App {

    private let navigator = StackNavigator()
    private let errorHandler = AlertErrorHandler()

    init() {
        register(API.self) { ClientAPI() }
        register(Navigator.self) { [self] in navigator }
        register(ErrorHandler.self) { [self] in errorHandler }
    }

    var body: some Scene {
        WindowGroup {
            MainScreen()
                .navigation(navigator)
                .errorHandling(errorHandler)
        }
    }
}
