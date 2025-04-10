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
