import Foundation

enum GetError: Error {
    case notFound
    case format
    case server
    case general
}

enum PostError: Error {
    case badRequest
    case notFound
    case server
    case general
}

extension GetError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .notFound:
            NSLocalizedString("error_not_found_title", comment: "")
        case .format:
            NSLocalizedString("error_format_title", comment: "")
        case .server:
            NSLocalizedString("error_server_title", comment: "")
        case .general:
            NSLocalizedString("error_general_title", comment: "")
        }
    }
}

extension PostError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .badRequest:
            NSLocalizedString("error_bad_request_title", comment: "")
        case .notFound:
            NSLocalizedString("error_not_found_title", comment: "")
        case .server:
            NSLocalizedString("error_server_title", comment: "")
        case .general:
            NSLocalizedString("error_general_title", comment: "")
        }
    }
}
