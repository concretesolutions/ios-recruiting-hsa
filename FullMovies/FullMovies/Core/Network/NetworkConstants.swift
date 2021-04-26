enum NetworkConstants {
    enum Endpoint : String {
        case base = "https://api.themoviedb.org"
        case popularMovies = "/movie/popular?api_key=%@&language=en-US&page=%@"
    }
    
    enum StatusCode : Int {
        case badRequest = 400
        case unauthorized = 401
        case internalServerError = 500
    }
    
    enum Version {
        static let v3 = "/3"
    }
    
    enum ApiKey {
        static let value = "9c79072d68244e228ff1969bef096234"
    }
}
