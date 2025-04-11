import SwiftUI

struct CartScreen: View {

    @Injected var navigator: Navigator

    init(params: CartParams) {

    }

    public var body: some View {
        Text("Hello Cart!")
    }
}
