import OHHTTPStubs
@testable import TheMovieDB
import XCTest

class MovieDBCloudSourceTests: XCTestCase {
    private let popularMoviesSubdirectory = "Mocks/PopularMovies"
    private let genresSubdirectory = "Mocks/Genres"

    private var apiKey: String!
    private var apiEndpoint: String!
    private var apiLanguage: String!

    override func setUp() {
        super.setUp()
        guard let configurations = Configurations(),
            let apiKey = configurations.string(for: .movieDbApiKey),
            let apiEndpoint = configurations.string(for: .movieDbApiEndpoint),
            let apiLanguage = configurations.string(for: .movieDBLanguage)
        else {
            XCTFail("Couldn't get configurations")
            return
        }
        self.apiKey = apiKey
        self.apiEndpoint = apiEndpoint
        self.apiLanguage = apiLanguage
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Popular movies list tests

    func testGetMovieListSuccess() {
        let urlPath = "/3/" + MovieDBCloudSourceSearchType.popularMovies.rawValue
        guard let mockData = MocksUtils.getDataFromJsonFile(named: "popularMovies.success", subdirectory: popularMoviesSubdirectory) else {
            XCTFail("Couldn't get mock data")
            return
        }

        guard let responseFromMock = try? JSONDecoder().decode(PopularMoviesResponseEntity.self, from: mockData) else {
            XCTFail("Couldn't get response object")
            return
        }

        stub(condition: isPath(urlPath)) { (_) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: mockData,
                                       statusCode: 200,
                                       headers: nil)
        }

        let expect = expectation(description: "Request must parse data correctly")
        let dataSource = MovieDBCloudSource()

        dataSource.getMovieList(apiUrl: apiEndpoint,
                                apiKey: apiKey,
                                page: nil,
                                language: apiLanguage,
                                success: { response in
                                    XCTAssertEqual(response, responseFromMock)
                                    expect.fulfill()
                                },
                                failure: { _ in
                                    XCTFail("Request return an error")
                                    expect.fulfill()
        })

        wait(for: [expect], timeout: 2.0)
    }

    func testGetMovieListFailure() {
        let urlPath = "/3/" + MovieDBCloudSourceSearchType.popularMovies.rawValue

        stub(condition: isPath(urlPath)) { (_) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: Data(),
                                       statusCode: 400,
                                       headers: nil)
        }

        let expect = expectation(description: "Request must fail without data")
        let dataSource = MovieDBCloudSource()

        dataSource.getMovieList(apiUrl: apiEndpoint,
                                apiKey: apiKey,
                                page: nil,
                                language: apiLanguage,
                                success: { _ in
                                    XCTFail("Request returned data")
                                    expect.fulfill()
                                },
                                failure: { error in
                                    if error is MovieDBErrorEntity {
                                        XCTFail("Got an error entity")
                                    }
                                    expect.fulfill()
        })

        wait(for: [expect], timeout: 2.0)
    }

    func testGetMovieListFailureWithResponse() {
        let urlPath = "/3/" + MovieDBCloudSourceSearchType.popularMovies.rawValue

        guard let mockData = MocksUtils.getDataFromJsonFile(named: "popularMovies.failure", subdirectory: popularMoviesSubdirectory) else {
            XCTFail("Couldn't get mock data")
            return
        }

        guard let responseFromMock = try? JSONDecoder().decode(MovieDBErrorEntity.self, from: mockData) else {
            XCTFail("Couldn't get response object")
            return
        }

        stub(condition: isPath(urlPath)) { (_) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: mockData,
                                       statusCode: 400,
                                       headers: nil)
        }

        let expect = expectation(description: "Request must fail with error data")
        let dataSource = MovieDBCloudSource()

        dataSource.getMovieList(apiUrl: apiEndpoint,
                                apiKey: apiKey,
                                page: nil,
                                language: apiLanguage,
                                success: { _ in
                                    XCTFail("Request returned data")
                                    expect.fulfill()
                                },
                                failure: { error in
                                    if let movieDBError = error as? MovieDBErrorEntity {
                                        XCTAssertEqual(movieDBError, responseFromMock)
                                    } else {
                                        XCTFail("Request didn't return an MovieDBErrorEntity error")
                                    }
                                    expect.fulfill()
        })

        wait(for: [expect], timeout: 2.0)
    }

    // MARK: - Genre list tests

    func testGetGenreListSuccess() {
        let urlPath = "/3/" + MovieDBCloudSourceSearchType.genreList.rawValue

        guard let mockData = MocksUtils.getDataFromJsonFile(named: "genres.success", subdirectory: genresSubdirectory) else {
            XCTFail("Couldn't get mock data")
            return
        }
        guard let responseFromMock = try? JSONDecoder().decode(GenreListReponseEntity.self, from: mockData) else {
            XCTFail("Couldn't get response object")
            return
        }

        stub(condition: isPath(urlPath)) { (_) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: mockData,
                                       statusCode: 200,
                                       headers: nil)
        }

        let expect = expectation(description: "Request must parse data correctly")
        let dataSource = MovieDBCloudSource()

        dataSource.getGenreList(apiUrl: apiEndpoint,
                                apiKey: apiKey,
                                language: apiLanguage,
                                success: { response in
                                    XCTAssertEqual(response, responseFromMock)
                                    expect.fulfill()
                                },
                                failure: { _ in
                                    XCTFail("Request return an error")
                                    expect.fulfill()
        })

        wait(for: [expect], timeout: 2.0)
    }

    func testGetGenreListFailure() {
        let urlPath = "/3/" + MovieDBCloudSourceSearchType.genreList.rawValue

        stub(condition: isPath(urlPath)) { (_) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: Data(),
                                       statusCode: 400,
                                       headers: nil)
        }

        let expect = expectation(description: "Request must fail without data")
        let dataSource = MovieDBCloudSource()

        dataSource.getGenreList(apiUrl: apiEndpoint,
                                apiKey: apiKey,
                                language: apiLanguage,
                                success: { _ in
                                    XCTFail("Request returned data")
                                    expect.fulfill()
                                },
                                failure: { error in
                                    if error is MovieDBErrorEntity {
                                        XCTFail("Got an error entity")
                                    }
                                    expect.fulfill()
        })

        wait(for: [expect], timeout: 2.0)
    }

    func testGetGenreListFailureWithResponse() {
        let urlPath = "/3/" + MovieDBCloudSourceSearchType.genreList.rawValue

        guard let mockData = MocksUtils.getDataFromJsonFile(named: "genres.failure", subdirectory: genresSubdirectory) else {
            XCTFail("Couldn't get mock data")
            return
        }

        guard let responseFromMock = try? JSONDecoder().decode(MovieDBErrorEntity.self, from: mockData) else {
            XCTFail("Couldn't get response object")
            return
        }

        stub(condition: isPath(urlPath)) { (_) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: mockData,
                                       statusCode: 400,
                                       headers: nil)
        }

        let expect = expectation(description: "Request must fail with error data")
        let dataSource = MovieDBCloudSource()

        dataSource.getGenreList(apiUrl: apiEndpoint,
                                apiKey: apiKey,
                                language: apiLanguage,
                                success: { _ in
                                    XCTFail("Request returned data")
                                    expect.fulfill()
                                },
                                failure: { error in
                                    if let movieDBError = error as? MovieDBErrorEntity {
                                        XCTAssertEqual(movieDBError, responseFromMock)
                                    } else {
                                        XCTFail("Request didn't return an MovieDBErrorEntity error")
                                    }
                                    expect.fulfill()
        })

        wait(for: [expect], timeout: 2.0)
    }
}
