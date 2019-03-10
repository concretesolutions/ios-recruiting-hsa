import Foundation
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
                      language _: String?,
                      success: @escaping (PopularMoviesResponseEntity) -> Void,
                      failure: @escaping (Error) -> Void) {
        switch status {
        case .success:
            let data = MocksUtils.getDataFromJsonFile(named: "popularMovies.success", subdirectory: popularMoviesSubdirectory)!
            let response = try! JSONDecoder().decode(PopularMoviesResponseEntity.self, from: data)
            success(response)
        case .failure:
            let data = MocksUtils.getDataFromJsonFile(named: "popularMovies.failure", subdirectory: popularMoviesSubdirectory)!
            let response = try! JSONDecoder().decode(MovieDBErrorEntity.self, from: data)
            failure(response)
        case .nilValue:
            let data = MocksUtils.getDataFromJsonFile(named: "popularMovies.nilResults", subdirectory: popularMoviesSubdirectory)!
            let response = try! JSONDecoder().decode(PopularMoviesResponseEntity.self, from: data)
            success(response)
        }
    }

    func getGenreList(apiUrl _: String,
                      apiKey _: String,
                      language _: String?,
                      success: @escaping (GenreListReponseEntity) -> Void,
                      failure: @escaping (Error) -> Void) {
        switch status {
        case .success:
            let data = MocksUtils.getDataFromJsonFile(named: "genres.success", subdirectory: genresSubdirectory)!
            let response = try! JSONDecoder().decode(GenreListReponseEntity.self, from: data)
            success(response)
        case .failure:
            let data = MocksUtils.getDataFromJsonFile(named: "genres.failure", subdirectory: genresSubdirectory)!
            let response = try! JSONDecoder().decode(MovieDBErrorEntity.self, from: data)
            failure(response)
        case .nilValue:
            let data = MocksUtils.getDataFromJsonFile(named: "genres.nilResult", subdirectory: genresSubdirectory)!
            let response = try! JSONDecoder().decode(GenreListReponseEntity.self, from: data)
            success(response)
        }
    }
}
