import Foundation

protocol MovieDBRepositoryProtocol {
    func getMovieList(configurations: ConfigurationsProtocol,
                      page: Int?,
                      success: @escaping ([MovieModel]) -> Void,
                      failure: @escaping (Error) -> Void)

    func getGenreList(configurations: ConfigurationsProtocol,
                      success: @escaping ([GenreModel]) -> Void,
                      failure: @escaping (Error) -> Void)
}

class MovieDBRepository: MovieDBRepositoryProtocol {
    private let dataSource: MovieDBCloudSourceProtocol

    init(dataSource: MovieDBCloudSourceProtocol) {
        self.dataSource = dataSource
    }

    func getMovieList(configurations: ConfigurationsProtocol,
                      page: Int?,
                      success: @escaping ([MovieModel]) -> Void,
                      failure: @escaping (Error) -> Void) {
        guard let apiKey = configurations.string(for: .movieDbApiKey),
            let apiEndpoint = configurations.string(for: .movieDbApiEndpoint),
            let language = configurations.string(for: .movieDBLanguage) else {
            failure(MovieDBRepositoryError.configurationsFail)
            return
        }

        dataSource.getMovieList(apiUrl: apiEndpoint,
                                apiKey: apiKey,
                                page: page,
                                language: language,
                                success: { response in
                                    guard let results = response.results else {
                                        failure(MovieDBRepositoryError.nilValue)
                                        return
                                    }
                                    let movies = results.compactMap({ MovieModel(entity: $0) })
                                    success(movies)
                                },
                                failure: { error in
                                    if let errorEntity = error as? MovieDBErrorEntity {
                                        failure(MovieDBErrorModel(entity: errorEntity))
                                    } else {
                                        failure(error)
                                    }
        })
    }

    func getGenreList(configurations: ConfigurationsProtocol,
                      success: @escaping ([GenreModel]) -> Void,
                      failure: @escaping (Error) -> Void) {
        guard let apiKey = configurations.string(for: .movieDbApiKey),
            let apiEndpoint = configurations.string(for: .movieDbApiEndpoint),
            let language = configurations.string(for: .movieDBLanguage) else {
            failure(MovieDBRepositoryError.configurationsFail)
            return
        }

        dataSource.getGenreList(apiUrl: apiEndpoint,
                                apiKey: apiKey,
                                language: language,
                                success: { response in
                                    guard let results = response.genres else {
                                        failure(MovieDBRepositoryError.nilValue)
                                        return
                                    }
                                    let genres = results.compactMap({ GenreModel(entity: $0) })
                                    success(genres)
                                },
                                failure: { error in
                                    if let errorEntity = error as? MovieDBErrorEntity {
                                        failure(MovieDBErrorModel(entity: errorEntity))
                                    } else {
                                        failure(error)
                                    }
        })
    }
}

enum MovieDBRepositoryError: Error {
    case configurationsFail, nilValue
}
