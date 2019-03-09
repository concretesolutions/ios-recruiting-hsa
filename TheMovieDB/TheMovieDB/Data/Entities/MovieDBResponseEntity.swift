import Foundation

struct MovieListResponseEntity: Codable {
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    let results: [MovieEntity]?

    private enum MovieListResponseCodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieListResponseCodingKeys.self)
        page = try container.decodeIfPresent(Int.self, forKey: .page)
        totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults)
        totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
        results = try container.decodeIfPresent([MovieEntity].self, forKey: .results)
    }
}
