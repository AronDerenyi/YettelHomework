import SwiftUI

struct CountiesScreen: View {

    @Injected var navigator: Navigator

    public var body: some View {
        Text("Hello Counties!").onTapGesture {
            navigator.push(.cart)
        }
    }
}
