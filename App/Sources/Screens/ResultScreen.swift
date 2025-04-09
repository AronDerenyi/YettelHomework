import SwiftUI

struct ResultScreen: View {

    @Injected var navigator: Navigator

    public var body: some View {
        Text("Hello Resul!").onTapGesture {
            navigator.clear()
        }
    }
}
