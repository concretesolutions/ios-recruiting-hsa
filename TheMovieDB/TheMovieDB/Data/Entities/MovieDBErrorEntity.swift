import Foundation

struct MovieDBErrorEntity: Codable, Error {
    let statusMessage: String
    let statusCode: Int

    private enum MovieDBErrorEntityCodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieDBErrorEntityCodingKeys.self)

        statusMessage = try container.decode(String.self, forKey: .statusMessage)
        statusCode = try container.decode(Int.self, forKey: .statusCode)
    }
}
