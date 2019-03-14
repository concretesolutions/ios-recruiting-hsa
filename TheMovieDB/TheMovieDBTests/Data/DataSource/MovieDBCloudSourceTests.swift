import OHHTTPStubs
import RxBlocking
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

        let dataSource = MovieDBCloudSource()
        let result = dataSource.getMovieList(apiUrl: apiEndpoint,
                                             apiKey: apiKey,
                                             page: nil,
                                             language: apiLanguage).toBlocking().materialize()

        switch result {
        case let .completed(elements):
            let response = elements.first
            XCTAssertEqual(response, responseFromMock)
        case .failed:
            XCTFail("Request return an error")
        }
    }

    func testGetMovieListFailure() {
        let urlPath = "/3/" + MovieDBCloudSourceSearchType.popularMovies.rawValue

        stub(condition: isPath(urlPath)) { (_) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: Data(),
                                       statusCode: 400,
                                       headers: nil)
        }

        let dataSource = MovieDBCloudSource()

        let result = dataSource.getMovieList(apiUrl: apiEndpoint,
                                             apiKey: apiKey,
                                             page: nil,
                                             language: apiLanguage).toBlocking().materialize()

        switch result {
        case .completed:
            XCTFail("Request returned data")
        case let .failed(_, error):
            if error is MovieDBErrorEntity {
                XCTFail("Got an error entity")
            }
        }
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

        let dataSource = MovieDBCloudSource()

        let result = dataSource.getMovieList(apiUrl: apiEndpoint,
                                             apiKey: apiKey,
                                             page: nil,
                                             language: apiLanguage).toBlocking().materialize()
        switch result {
        case .completed:
            XCTFail("Request returned data")
        case let .failed(_, error):
            if let movieDBError = error as? MovieDBErrorEntity {
                XCTAssertEqual(movieDBError, responseFromMock)
            } else {
                XCTFail("Request didn't return an MovieDBErrorEntity error")
            }
        }
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

        let dataSource = MovieDBCloudSource()

        let result = dataSource.getGenreList(apiUrl: apiEndpoint,
                                             apiKey: apiKey,
                                             language: apiLanguage).toBlocking().materialize()

        switch result {
        case let .completed(elements):
            let response = elements.first
            XCTAssertEqual(response, responseFromMock)
        case .failed:
            XCTFail("Request return an error")
        }
    }

    func testGetGenreListFailure() {
        let urlPath = "/3/" + MovieDBCloudSourceSearchType.genreList.rawValue

        stub(condition: isPath(urlPath)) { (_) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: Data(),
                                       statusCode: 400,
                                       headers: nil)
        }

        let dataSource = MovieDBCloudSource()

        let result = dataSource.getGenreList(apiUrl: apiEndpoint,
                                             apiKey: apiKey,
                                             language: apiLanguage).toBlocking().materialize()

        switch result {
        case .completed:
            XCTFail("Request returned data")
        case let .failed(_, error):
            if error is MovieDBErrorEntity {
                XCTFail("Got an error entity")
            }
        }
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

        let dataSource = MovieDBCloudSource()

        let result = dataSource.getGenreList(apiUrl: apiEndpoint,
                                             apiKey: apiKey,
                                             language: apiLanguage).toBlocking().materialize()

        switch result {
        case .completed:
            XCTFail("Request returned data")
        case let .failed(_, error):
            if let movieDBError = error as? MovieDBErrorEntity {
                XCTAssertEqual(movieDBError, responseFromMock)
            } else {
                XCTFail("Request didn't return an MovieDBErrorEntity error")
            }
        }
    }
}
