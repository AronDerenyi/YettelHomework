import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession

@main
struct Application: App {

    var body: some Scene {
        WindowGroup {
            MainScreen()
                .navigator(inject())
        }
    }
}
