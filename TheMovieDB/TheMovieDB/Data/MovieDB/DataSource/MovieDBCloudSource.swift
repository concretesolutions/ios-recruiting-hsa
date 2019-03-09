import Alamofire

protocol MovieDBCloudSourceProtocol {
    func getMovieList(apiUrl: String,
                      apiKey: String,
                      success: @escaping (MovieListResponseEntity) -> Void,
                      failure: @escaping (Error) -> Void)
}

class MovieDBCloudSource: MovieDBCloudSourceProtocol {
    func getMovieList(apiUrl: String,
                      apiKey: String,
                      success: @escaping (MovieListResponseEntity) -> Void,
                      failure: @escaping (Error) -> Void) {
        guard let url = URL(string: apiUrl + "popular") else {
            failure(MovieDBCloudSourceError.badURL)
            return
        }
        let parameters: [String: Any] = [
            "api_key": apiKey
        ]
        let request = Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)

        request.responseData { response in
            switch response.result {
            case let .success(data):
                guard let responseCodable = try? JSONDecoder().decode(MovieListResponseEntity.self, from: data) else {
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
