import Foundation

protocol MovieDBRepositoryProtocol {
    func getMovieList(configurations: ConfigurationsProtocol,
                      success: @escaping ([MovieModel]) -> Void,
                      failure: @escaping (Error) -> Void)
}

class MovieDBRepository: MovieDBRepositoryProtocol {
    private let dataSource: MovieDBCloudSourceProtocol

    init(dataSource: MovieDBCloudSourceProtocol) {
        self.dataSource = dataSource
    }

    func getMovieList(configurations: ConfigurationsProtocol,
                      success: @escaping ([MovieModel]) -> Void,
                      failure: @escaping (Error) -> Void) {
        guard let apiKey = configurations.string(for: .movieDbApiKey),
            let apiEndpoint = configurations.string(for: .movieDbApiEndpoint) else {
            failure(MovieDBRepositoryError.configurationsFail)
            return
        }

        dataSource.getMovieList(apiUrl: apiEndpoint,
                                apiKey: apiKey,
                                success: { response in
                                    guard let results = response.results else {
                                        failure(MovieDBRepositoryError.nilValue)
                                        return
                                    }
                                    let movies = results.compactMap({ MovieModel(entity: $0) })
                                    success(movies)
                                },
                                failure: failure)
    }
}

enum MovieDBRepositoryError: Error {
    case configurationsFail, nilValue
}
