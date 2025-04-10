import SwiftUI

struct Loader<T, Content: View, Placeholder: View>: View {

    private let type: LoaderType<T, Content>
    private let placeholder: () -> Placeholder

    init(
        _ value: T?,
        @ViewBuilder content: @escaping (T) -> Content,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.type = .nullable(value: value, content: content)
        self.placeholder = placeholder
    }

    init(
        _ value: Bool,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.type = .boolean(value: value, content: content)
        self.placeholder = placeholder
    }

    var body: some View {
        switch type {
        case .boolean(false, _):
            placeholder()
        case .boolean(true, let content):
            content()
        case .nullable(nil, _):
            placeholder()
        case .nullable(.some(let value), let content):
            content(value)
        }
    }
}

private enum LoaderType<T, Content: View> {
    case boolean(value: Bool, content: () -> Content)
    case nullable(value: T?, content: (T) -> Content)
}
