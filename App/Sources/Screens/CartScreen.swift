import SwiftUI

struct CartScreen: View {

    @Injected var navigator: Navigator

    public var body: some View {
        Text("Hello Cart!").onTapGesture {
            navigator.push(.result)
        }
    }
}
