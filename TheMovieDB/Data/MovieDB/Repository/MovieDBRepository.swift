import Foundation
import RxSwift

protocol MovieDBRepositoryProtocol {
    func getMovieList(configurations: ConfigurationsProtocol, page: Int?) -> Single<[MovieModel]>

    func getGenreList(configurations: ConfigurationsProtocol) -> Single<[GenreModel]>
}

class MovieDBRepository: MovieDBRepositoryProtocol {
    private let dataSource: MovieDBCloudSourceProtocol

    init(dataSource: MovieDBCloudSourceProtocol) {
        self.dataSource = dataSource
    }

    func getMovieList(configurations: ConfigurationsProtocol, page: Int?) -> Single<[MovieModel]> {
        guard let apiKey = configurations.string(for: .movieDbApiKey),
            let apiEndpoint = configurations.string(for: .movieDbApiEndpoint),
            let language = configurations.string(for: .movieDBLanguage) else {
            return .error(MovieDBRepositoryError.configurationsFail)
        }

        let result = dataSource.getMovieList(apiUrl: apiEndpoint, apiKey: apiKey, page: page, language: language).flatMap { (response) -> Single<[MovieModel]> in
            guard let results = response.results else {
                return .error(MovieDBRepositoryError.nilValue)
            }
            let movies = results.compactMap({ MovieModel(entity: $0) })
            return .just(movies)
        }.catchError { (error) -> Single<[MovieModel]> in
            if let errorEntity = error as? MovieDBErrorEntity {
                return .error(MovieDBErrorModel(entity: errorEntity))
            } else {
                return .error(error)
            }
        }
        return result
    }

    func getGenreList(configurations: ConfigurationsProtocol) -> Single<[GenreModel]> {
        guard let apiKey = configurations.string(for: .movieDbApiKey),
            let apiEndpoint = configurations.string(for: .movieDbApiEndpoint),
            let language = configurations.string(for: .movieDBLanguage) else {
            return .error(MovieDBRepositoryError.configurationsFail)
        }

        let result = dataSource.getGenreList(apiUrl: apiEndpoint, apiKey: apiKey, language: language).flatMap { (response) -> Single<[GenreModel]> in
            guard let results = response.genres else {
                return .error(MovieDBRepositoryError.nilValue)
            }
            let genres = results.compactMap({ GenreModel(entity: $0) })
            return .just(genres)
        }.catchError { (error) -> Single<[GenreModel]> in
            if let errorEntity = error as? MovieDBErrorEntity {
                return .error(MovieDBErrorModel(entity: errorEntity))
            } else {
                return .error(error)
            }
        }
        return result
    }
}

enum MovieDBRepositoryError: Error {
    case configurationsFail, nilValue
}
