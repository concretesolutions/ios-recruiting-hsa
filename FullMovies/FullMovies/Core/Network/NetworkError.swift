public struct NetworkError: Decodable {
    public let message: String
    public let status: Int?

    public init(message: String, status: Int?) {
        self.message = message
        self.status = status
    }
}
