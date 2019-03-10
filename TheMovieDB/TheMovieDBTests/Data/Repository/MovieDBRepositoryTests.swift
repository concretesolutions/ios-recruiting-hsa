import OHHTTPStubs
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

        let expect = expectation(description: "Array of movies must be equal")
        let dataSource = MovieDBCloudSourceMock(status: .success)
        let repository = MovieDBRepository(dataSource: dataSource)

        repository.getMovieList(configurations: configurations,
                                page: nil,
                                success: { movieList in
                                    XCTAssertEqual(movieList, movieArray)
                                    expect.fulfill()
                                },
                                failure: { _ in
                                    XCTFail("Repository return an error")
                                    expect.fulfill()
        })

        wait(for: [expect], timeout: 2.0)
    }

    func testGetMovieListFailure() {
        guard let responseData = MocksUtils.getDataFromJsonFile(named: "popularMovies.failure", subdirectory: popularMoviesSubdirectory),
            let errorResponse = try? JSONDecoder().decode(MovieDBErrorEntity.self, from: responseData) else {
            XCTFail("Couldn't init error response")
            return
        }
        let errorModel = MovieDBErrorModel(entity: errorResponse)

        let expect = expectation(description: "Repository must trigger a failure")
        let dataSource = MovieDBCloudSourceMock(status: .failure)
        let repository = MovieDBRepository(dataSource: dataSource)

        repository.getMovieList(configurations: configurations,
                                page: nil,
                                success: { _ in
                                    XCTFail("Repository return an array")
                                    expect.fulfill()
                                },
                                failure: { error in
                                    if let movieDBError = error as? MovieDBErrorModel {
                                        XCTAssertEqual(movieDBError, errorModel)
                                    } else {
                                        XCTFail("Error is not an instance of MovieDBErrorModel")
                                    }
                                    expect.fulfill()
        })

        wait(for: [expect], timeout: 2.0)
    }

    func testGetMovieListNilResult() {
        let expect = expectation(description: "Repository must trigger a nil value failure")
        let dataSource = MovieDBCloudSourceMock(status: .nilValue)
        let repository = MovieDBRepository(dataSource: dataSource)

        repository.getMovieList(configurations: configurations,
                                page: nil,
                                success: { _ in
                                    XCTFail("Repository return an array")
                                    expect.fulfill()
                                },
                                failure: { error in
                                    if let movieDBRepositoryError = error as? MovieDBRepositoryError {
                                        XCTAssertEqual(movieDBRepositoryError, MovieDBRepositoryError.nilValue)
                                    } else {
                                        XCTFail("Error is not an instance of MovieDBErrorModel")
                                    }
                                    expect.fulfill()
        })

        wait(for: [expect], timeout: 2.0)
    }

    func testGetGenreListSuccess() {
        guard let responseData = MocksUtils.getDataFromJsonFile(named: "genres.success", subdirectory: genresSubdirectory),
            let response = try? JSONDecoder().decode(GenreListReponseEntity.self, from: responseData),
            let genresArray = response.genres?.compactMap({ GenreModel(entity: $0) }) else {
            XCTFail("Couldn't init genres array")
            return
        }

        let expect = expectation(description: "Array of genres must be equal")
        let dataSource = MovieDBCloudSourceMock(status: .success)
        let repository = MovieDBRepository(dataSource: dataSource)

        repository.getGenreList(configurations: configurations,
                                success: { genres in
                                    XCTAssertEqual(genres, genresArray)
                                    expect.fulfill()
                                },
                                failure: { _ in
                                    XCTFail("Repository return an error")
                                    expect.fulfill()
        })

        wait(for: [expect], timeout: 2.0)
    }

    func testGetGenreListFailure() {
        guard let responseData = MocksUtils.getDataFromJsonFile(named: "genres.failure", subdirectory: genresSubdirectory),
            let errorResponse = try? JSONDecoder().decode(MovieDBErrorEntity.self, from: responseData) else {
            XCTFail("Couldn't init error response")
            return
        }
        let errorModel = MovieDBErrorModel(entity: errorResponse)

        let expect = expectation(description: "Repository must trigger a failure")
        let dataSource = MovieDBCloudSourceMock(status: .failure)
        let repository = MovieDBRepository(dataSource: dataSource)

        repository.getGenreList(configurations: configurations,
                                success: { _ in
                                    XCTFail("Repository return an array")
                                    expect.fulfill()
                                },
                                failure: { error in
                                    if let movieDBError = error as? MovieDBErrorModel {
                                        XCTAssertEqual(movieDBError, errorModel)
                                    } else {
                                        XCTFail("Error is not an instance of MovieDBErrorModel")
                                    }
                                    expect.fulfill()
        })

        wait(for: [expect], timeout: 2.0)
    }

    func testGetGenreListNilResult() {
        let expect = expectation(description: "Repository must trigger a nil value failure")
        let dataSource = MovieDBCloudSourceMock(status: .nilValue)
        let repository = MovieDBRepository(dataSource: dataSource)

        repository.getGenreList(configurations: configurations,
                                success: { _ in
                                    XCTFail("Repository return an array")
                                    expect.fulfill()
                                },
                                failure: { error in
                                    if let movieDBRepositoryError = error as? MovieDBRepositoryError {
                                        XCTAssertEqual(movieDBRepositoryError, MovieDBRepositoryError.nilValue)
                                    } else {
                                        XCTFail("Error is not an instance of MovieDBErrorModel")
                                    }
                                    expect.fulfill()
        })

        wait(for: [expect], timeout: 2.0)
    }
}
