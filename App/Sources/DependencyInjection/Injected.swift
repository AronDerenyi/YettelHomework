import SwiftUI

@propertyWrapper
struct Injected<T> {
    var wrappedValue: T

    init() {
        self.wrappedValue = inject()
    }
}
