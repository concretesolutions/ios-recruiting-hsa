import Alamofire
import RxSwift

protocol MovieDBCloudSourceProtocol {
    func getMovieList(apiUrl: String,
                      apiKey: String,
                      page: Int?,
                      language: String?) -> Single<PopularMoviesResponseEntity>

    func getGenreList(apiUrl: String,
                      apiKey: String,
                      language: String?) -> Single<GenreListReponseEntity>
}

enum MovieDBCloudSourceSearchType: String {
    case popularMovies = "movie/popular"
    case genreList = "genre/movie/list"
}

class MovieDBCloudSource: MovieDBCloudSourceProtocol {
    func getMovieList(apiUrl: String,
                      apiKey: String,
                      page: Int?,
                      language: String?) -> Single<PopularMoviesResponseEntity> {
        guard let url = URL(string: apiUrl + MovieDBCloudSourceSearchType.popularMovies.rawValue) else {
            return .error(MovieDBCloudSourceError.badURL)
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

        let request = Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate()

        return Single.create { single in
            request.responseData { response in
                switch response.result {
                case let .success(data):
                    guard let responseCodable = try? JSONDecoder().decode(PopularMoviesResponseEntity.self, from: data) else {
                        single(.error(MovieDBCloudSourceError.parseError))
                        return
                    }
                    single(.success(responseCodable))
                case let .failure(error):
                    if let data = response.data, let errorCodable = try? JSONDecoder().decode(MovieDBErrorEntity.self, from: data) {
                        single(.error(errorCodable))
                    } else {
                        single(.error(error))
                    }
                }
            }
            return Disposables.create()
        }
    }

    func getGenreList(apiUrl: String,
                      apiKey: String,
                      language: String?) -> Single<GenreListReponseEntity> {
        guard let url = URL(string: apiUrl + MovieDBCloudSourceSearchType.genreList.rawValue) else {
            return .error(MovieDBCloudSourceError.badURL)
        }
        var parameters: [String: Any] = [
            "api_key": apiKey
        ]

        if let language = language {
            parameters["language"] = language
        }

        let request = Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate()

        return Single.create { single in
            request.responseData { response in
                switch response.result {
                case let .success(data):
                    guard let responseCodable = try? JSONDecoder().decode(GenreListReponseEntity.self, from: data) else {
                        single(.error(MovieDBCloudSourceError.parseError))
                        return
                    }
                    single(.success(responseCodable))
                case let .failure(error):
                    if let data = response.data, let errorCodable = try? JSONDecoder().decode(MovieDBErrorEntity.self, from: data) {
                        single(.error(errorCodable))
                    } else {
                        single(.error(error))
                    }
                }
            }
            return Disposables.create()
        }
    }
}

enum MovieDBCloudSourceError: Error {
    case badURL, parseError
}
