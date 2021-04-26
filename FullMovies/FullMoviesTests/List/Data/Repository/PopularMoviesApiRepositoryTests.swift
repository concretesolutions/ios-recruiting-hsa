@testable import FullMovies
import XCTest

class PopularMoviesApiRepositoryTests: TestCase {

    var sut : PopularMoviesApiRepository!
    var popularMoviesRestApiMock : PopularMoviesRestApiMock!
    
    override func setUp() {
        super.setUp()
        popularMoviesRestApiMock = PopularMoviesRestApiMock()
        sut = PopularMoviesApiRepository(
            popularMoviesRestApi: popularMoviesRestApiMock,
            errorMapper: ErrorModelMapper())
    }
    
    func testListSuccess() {
        popularMoviesRestApiMock.success = true
        let page = "1"
        let exp = expectation(description: #function)
        
        sut.list(in: page) { (model, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(model)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
    
    func testListFail() {
        popularMoviesRestApiMock.success = false
        let page = "1"
        let exp = expectation(description: #function)
        
        sut.list(in: page) { (model, error) in
            //XCTAssertNotNil(error)
            XCTAssertNil(model)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
    }
}
