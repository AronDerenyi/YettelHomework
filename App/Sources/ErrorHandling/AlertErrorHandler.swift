import SwiftUI

@MainActor
class AlertErrorHandler: ObservableObject, ErrorHandler {

    @Published fileprivate var error: AnyLocalizedError?
    @Published fileprivate var showAlert = false

    func handle<S, F: LocalizedError>(_ action: () async -> Result<S, F>) async -> S? {
        switch await action() {
        case .success(let success):
            return success
        case .failure(let failure):
            error = AnyLocalizedError(error: failure)
            showAlert = true
            return nil
        }
    }
}

extension View {
    func errorHandling(_ errorHandler: AlertErrorHandler) -> some View {
        modifier(AlertErrorHandlerModifier(errorHandler: errorHandler))
    }
}

private struct AlertErrorHandlerModifier: ViewModifier {

    @StateObject var errorHandler: AlertErrorHandler

    func body(content: Content) -> some View {
        content.alert(
            isPresented: $errorHandler.showAlert,
            error: errorHandler.error
        ) {
            Button("error_dismiss_button") {
                errorHandler.error = nil
                errorHandler.showAlert = false
            }
        }
    }
}

private struct AnyLocalizedError: LocalizedError {

    let error: LocalizedError

    var errorDescription: String? {
        error.errorDescription
    }

    var failureReason: String? {
        error.failureReason
    }

    var recoverySuggestion: String? {
        error.recoverySuggestion
    }

    var helpAnchor: String? {
        error.helpAnchor
    }
}
