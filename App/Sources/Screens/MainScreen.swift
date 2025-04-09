import SwiftUI
import OpenAPIURLSession

public struct MainScreen: View {

    @State var text = "Hello, World!"
    let client = Client(
        serverURL: try! Servers.Server1.url(),
        transport: URLSessionTransport()
    )

    @Injected var navigator: Navigator

    public init() {}

    public var body: some View {
        ScrollView {
            Text(text)
                .padding()
                .onTapGesture {
                    navigator.push(.counties)
                }
        }
        .refreshable {
            try! await Task.sleep(for: .seconds(5))
        }
//            .task {
//                guard case .ok(let vehicle) = try! await client.getVehicleInfo() else {
//                    return
//                }
//
//                guard case .json(let vehicle) = vehicle.body else {
//                    return
//                }
//
//                text = "\(vehicle.name)"
//            }
    }
}
