import Foundation

struct GenreListReponseEntity: Codable, Equatable {
    let genres: [GenreEntity]?

    private enum GenreListReponseEntityCodingKeys: String, CodingKey {
        case genres
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GenreListReponseEntityCodingKeys.self)
        genres = try container.decodeIfPresent([GenreEntity].self, forKey: .genres)
    }
}
