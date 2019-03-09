import Foundation

struct GenreEntity: Codable {
    let id: Int?
    let name: String?

    private enum GenreEntityCodingKeys: String, CodingKey {
        case id, name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GenreEntityCodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }
}
