struct Movies: Codable {
    let page: Int?
    let list : [MovieInfo]?
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case list = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
