import SwiftUI

protocol ErrorHandler {
    func handle<S, F: LocalizedError>(_ action: () async -> Result<S, F>) async -> S?
}
