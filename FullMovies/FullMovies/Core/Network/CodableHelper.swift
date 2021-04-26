import Foundation

public class CodableHelper {
    private let decoder: JSONDecoder

    public init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }

    public func decodeNetworkObject<D: Decodable>(object: Data) throws -> D {
        do {
            let target = try decoder.decode(D.self, from: object)
            return target
        } catch {
            throw error
        }
    }

    public func decodeStringObject<D: Decodable>(object: String) -> D {
        guard let data = object.data(using: .utf8) else {
            fatalError("Could not encode object: \(object)")
        }
        do {
            let target: D = try decodeNetworkObject(object: data)
            return target
        } catch {
            fatalError("Could not transform object of class \(D.self)")
        }
    }

    public func generateErrorFor(object: Data? = Data()) -> NetworkError {
        if
            let data = object,
            let error = try? decoder.decode(NetworkError.self, from: data),
            let status = error.status,
            status < NetworkConstants.StatusCode.internalServerError.rawValue {
            return error
        } else {
            return defaultError()
        }
    }

    private func defaultError() -> NetworkError {
        return NetworkError(
            message: "Try Again",
            status: NetworkConstants.StatusCode.internalServerError.rawValue
        )
    }
}
