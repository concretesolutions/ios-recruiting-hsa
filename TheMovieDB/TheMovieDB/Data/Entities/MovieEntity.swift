import Foundation

struct MovieEntity: Codable {
    let voteCount: Int?
    let id: Int?
    let video: Bool?
    let voteAverage: Double?
    let title: String?
    let popularity: Double?
    let posterPath: String?
    let originalLanguage: String?
    let originalTitle: String?
    let genreIDS: [Int]?
    let backdropPath: String?
    let adult: Bool?
    let overview: String?
    let releaseDate: String?

    private enum MovieEntityCodingKeys: String, CodingKey {
        case id, video, title, popularity, adult, overview
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieEntityCodingKeys.self)

        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        video = try container.decodeIfPresent(Bool.self, forKey: .video)
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage)
        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        genreIDS = try container.decodeIfPresent([Int].self, forKey: .genreIDS)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        adult = try container.decodeIfPresent(Bool.self, forKey: .adult)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
    }
}
