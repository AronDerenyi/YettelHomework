import SwiftUI

@propertyWrapper
public struct Injected<T> {
    public var wrappedValue: T

    public init() {
        self.wrappedValue = Injection.shared.inject()
    }
}
