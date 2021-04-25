@testable import FullMovies
import XCTest

class GetPopularMoviesUseCaseTests: TestCase {
    
    var sut : GetPopularMoviesUseCase!
    var repository: PopularMoviesRepositoryMock!
    
    override func setUp() {
        super.setUp()
        repository = PopularMoviesRepositoryMock()
        sut = GetPopularMoviesUseCase(popularMoviesRepository: repository)
    }
    
    func testGetListMoviesSucces(){
        repository.success = true
        
        let exp = expectation(description: #function)
        let apiKey = "12345"
        sut.execute(with: apiKey) { (response, error) in
            exp.fulfill()
            XCTAssertNil(error)
            XCTAssertNotNil(response)
        }
        wait(for: [exp], timeout: 10)
    }
    
    func testGetListMoviesFail(){
        repository.success = false
        
        let exp = expectation(description: #function)
        let apiKey = ""
        sut.execute(with: apiKey) { (response, error) in
            exp.fulfill()
            XCTAssertNil(response)
            XCTAssertNotNil(error)
        }
        wait(for: [exp], timeout: 10)
    }
}
