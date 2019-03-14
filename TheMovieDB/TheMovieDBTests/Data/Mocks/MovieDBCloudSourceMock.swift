import Foundation
import RxSwift
@testable import TheMovieDB

class MovieDBCloudSourceMock: MovieDBCloudSourceProtocol {
    private let status: MockStatus
    private let popularMoviesSubdirectory = "Mocks/PopularMovies"
    private let genresSubdirectory = "Mocks/Genres"

    init(status: MockStatus) {
        self.status = status
    }

    func getMovieList(apiUrl _: String,
                      apiKey _: String,
                      page _: Int?,
                      language _: String?) -> Single<PopularMoviesResponseEntity> {
        switch status {
        case .success:
            let data = MocksUtils.getDataFromJsonFile(named: "popularMovies.success", subdirectory: popularMoviesSubdirectory)!
            let response = try! JSONDecoder().decode(PopularMoviesResponseEntity.self, from: data)
            return .just(response)
        case .failure:
            let data = MocksUtils.getDataFromJsonFile(named: "popularMovies.failure", subdirectory: popularMoviesSubdirectory)!
            let response = try! JSONDecoder().decode(MovieDBErrorEntity.self, from: data)
            return .error(response)
        case .nilValue:
            let data = MocksUtils.getDataFromJsonFile(named: "popularMovies.nilResults", subdirectory: popularMoviesSubdirectory)!
            let response = try! JSONDecoder().decode(PopularMoviesResponseEntity.self, from: data)
            return .just(response)
        }
    }

    func getGenreList(apiUrl _: String,
                      apiKey _: String,
                      language _: String?) -> Single<GenreListReponseEntity> {
        switch status {
        case .success:
            let data = MocksUtils.getDataFromJsonFile(named: "genres.success", subdirectory: genresSubdirectory)!
            let response = try! JSONDecoder().decode(GenreListReponseEntity.self, from: data)
            return .just(response)
        case .failure:
            let data = MocksUtils.getDataFromJsonFile(named: "genres.failure", subdirectory: genresSubdirectory)!
            let response = try! JSONDecoder().decode(MovieDBErrorEntity.self, from: data)
            return .error(response)
        case .nilValue:
            let data = MocksUtils.getDataFromJsonFile(named: "genres.nilResult", subdirectory: genresSubdirectory)!
            let response = try! JSONDecoder().decode(GenreListReponseEntity.self, from: data)
            return .just(response)
        }
    }
}
