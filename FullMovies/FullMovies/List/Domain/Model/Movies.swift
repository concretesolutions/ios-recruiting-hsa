struct Movies: Codable {
    let page: Int
    let list : [MovieInfo]
    let totalPages: Int
    let totalResults: Int
}
