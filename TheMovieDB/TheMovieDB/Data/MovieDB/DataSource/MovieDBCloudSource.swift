import Alamofire

protocol MovieDBCloudSourceProtocol {
    func getMovieList(apiUrl: String,
                      apiKey: String,
                      page: Int?,
                      language: String?,
                      success: @escaping (PopularMoviesResponseEntity) -> Void,
                      failure: @escaping (Error) -> Void)

    func getGenreList(apiUrl: String,
                      apiKey: String,
                      language: String?,
                      success: @escaping (GenreListReponseEntity) -> Void,
                      failure: @escaping (Error) -> Void)
}

enum MovieDBCloudSourceSearchType: String {
    case popularMovies = "movie/popular"
    case genreList = "genre/movie/list"
}

class MovieDBCloudSource: MovieDBCloudSourceProtocol {
    func getMovieList(apiUrl: String,
                      apiKey: String,
                      page: Int?,
                      language: String?,
                      success: @escaping (PopularMoviesResponseEntity) -> Void,
                      failure: @escaping (Error) -> Void) {
        guard let url = URL(string: apiUrl + MovieDBCloudSourceSearchType.popularMovies.rawValue) else {
            failure(MovieDBCloudSourceError.badURL)
            return
        }
        var parameters: [String: Any] = [
            "api_key": apiKey
        ]
        if let page = page {
            parameters["page"] = page
        }

        if let language = language {
            parameters["language"] = language
        }

        let request = Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)

        request.responseData { response in
            switch response.result {
            case let .success(data):
                guard let responseCodable = try? JSONDecoder().decode(PopularMoviesResponseEntity.self, from: data) else {
                    failure(MovieDBCloudSourceError.parseError)
                    return
                }
                success(responseCodable)
            case let .failure(error):
                if let data = response.data, let errorCodable = try? JSONDecoder().decode(MovieDBErrorEntity.self, from: data) {
                    failure(errorCodable)
                } else {
                    failure(error)
                }
            }
        }
    }

    func getGenreList(apiUrl: String,
                      apiKey: String,
                      language: String?,
                      success: @escaping (GenreListReponseEntity) -> Void,
                      failure: @escaping (Error) -> Void) {
        guard let url = URL(string: apiUrl + MovieDBCloudSourceSearchType.genreList.rawValue) else {
            failure(MovieDBCloudSourceError.badURL)
            return
        }
        var parameters: [String: Any] = [
            "api_key": apiKey
        ]

        if let language = language {
            parameters["language"] = language
        }

        let request = Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
        request.responseData { response in
            switch response.result {
            case let .success(data):
                guard let responseCodable = try? JSONDecoder().decode(GenreListReponseEntity.self, from: data) else {
                    failure(MovieDBCloudSourceError.parseError)
                    return
                }
                success(responseCodable)
            case let .failure(error):
                if let data = response.data, let errorCodable = try? JSONDecoder().decode(MovieDBErrorEntity.self, from: data) {
                    failure(errorCodable)
                } else {
                    failure(error)
                }
            }
        }
    }
}

enum MovieDBCloudSourceError: Error {
    case badURL, parseError
}
