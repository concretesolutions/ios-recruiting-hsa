import RxBlocking
@testable import TheMovieDB
import XCTest

class MovieDBRepositoryTests: XCTestCase {
    private let popularMoviesSubdirectory = "Mocks/PopularMovies"
    private let genresSubdirectory = "Mocks/Genres"
    private var configurations: Configurations!

    override func setUp() {
        super.setUp()
        guard let configurations = Configurations() else {
            XCTFail("Couldn't init configurations object")
            return
        }
        self.configurations = configurations
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetMovieListSuccess() {
        guard let responseData = MocksUtils.getDataFromJsonFile(named: "popularMovies.success", subdirectory: popularMoviesSubdirectory),
            let response = try? JSONDecoder().decode(PopularMoviesResponseEntity.self, from: responseData),
            let movieArray = response.results?.compactMap({ MovieModel(entity: $0) }) else {
            XCTFail("Couldn't init movies array")
            return
        }

        let dataSource = MovieDBCloudSourceMock(status: .success)
        let repository = MovieDBRepository(dataSource: dataSource)
        let result = repository.getMovieList(configurations: configurations, page: nil).toBlocking().materialize()

        switch result {
        case let .completed(elements):
            let movieList = elements.first
            XCTAssertEqual(movieList, movieArray)
        case .failed:
            XCTFail("Repository return an error")
        }
    }

    func testGetMovieListFailure() {
        guard let responseData = MocksUtils.getDataFromJsonFile(named: "popularMovies.failure", subdirectory: popularMoviesSubdirectory),
            let errorResponse = try? JSONDecoder().decode(MovieDBErrorEntity.self, from: responseData) else {
            XCTFail("Couldn't init error response")
            return
        }
        let errorModel = MovieDBErrorModel(entity: errorResponse)
        let dataSource = MovieDBCloudSourceMock(status: .failure)
        let repository = MovieDBRepository(dataSource: dataSource)
        let result = repository.getMovieList(configurations: configurations, page: nil).toBlocking().materialize()

        switch result {
        case .completed:
            XCTFail("Repository return an array")
        case let .failed(_, error):
            if let movieDBError = error as? MovieDBErrorModel {
                XCTAssertEqual(movieDBError, errorModel)
            } else {
                XCTFail("Error is not an instance of MovieDBErrorModel")
            }
        }
    }

    func testGetMovieListNilResult() {
        let dataSource = MovieDBCloudSourceMock(status: .nilValue)
        let repository = MovieDBRepository(dataSource: dataSource)
        let result = repository.getMovieList(configurations: configurations, page: nil).toBlocking().materialize()

        switch result {
        case .completed:
            XCTFail("Repository return an array")
        case let .failed(_, error):
            if let movieDBRepositoryError = error as? MovieDBRepositoryError {
                XCTAssertEqual(movieDBRepositoryError, MovieDBRepositoryError.nilValue)
            } else {
                XCTFail("Error is not an instance of MovieDBRepositoryError")
            }
        }
    }

    func testGetGenreListSuccess() {
        guard let responseData = MocksUtils.getDataFromJsonFile(named: "genres.success", subdirectory: genresSubdirectory),
            let response = try? JSONDecoder().decode(GenreListReponseEntity.self, from: responseData),
            let genresArray = response.genres?.compactMap({ GenreModel(entity: $0) }) else {
            XCTFail("Couldn't init genres array")
            return
        }

        let dataSource = MovieDBCloudSourceMock(status: .success)
        let repository = MovieDBRepository(dataSource: dataSource)
        let result = repository.getGenreList(configurations: configurations).toBlocking().materialize()

        switch result {
        case let .completed(elements):
            let genres = elements.first
            XCTAssertEqual(genres, genresArray)
        case .failed:
            XCTFail("Repository return an error")
        }
    }

    func testGetGenreListFailure() {
        guard let responseData = MocksUtils.getDataFromJsonFile(named: "genres.failure", subdirectory: genresSubdirectory),
            let errorResponse = try? JSONDecoder().decode(MovieDBErrorEntity.self, from: responseData) else {
            XCTFail("Couldn't init error response")
            return
        }
        let errorModel = MovieDBErrorModel(entity: errorResponse)
        let dataSource = MovieDBCloudSourceMock(status: .failure)
        let repository = MovieDBRepository(dataSource: dataSource)

        let result = repository.getGenreList(configurations: configurations).toBlocking().materialize()

        switch result {
        case .completed:
            XCTFail("Repository return an array")
        case let .failed(_, error):
            if let movieDBError = error as? MovieDBErrorModel {
                XCTAssertEqual(movieDBError, errorModel)
            } else {
                XCTFail("Error is not an instance of MovieDBErrorModel")
            }
        }
    }

    func testGetGenreListNilResult() {
        let dataSource = MovieDBCloudSourceMock(status: .nilValue)
        let repository = MovieDBRepository(dataSource: dataSource)
        let result = repository.getGenreList(configurations: configurations).toBlocking().materialize()

        switch result {
        case .completed:
            XCTFail("Repository return an array")
        case let .failed(_, error):
            if let movieDBRepositoryError = error as? MovieDBRepositoryError {
                XCTAssertEqual(movieDBRepositoryError, MovieDBRepositoryError.nilValue)
            } else {
                XCTFail("Error is not an instance of MovieDBRepositoryError")
            }
        }
    }
}
