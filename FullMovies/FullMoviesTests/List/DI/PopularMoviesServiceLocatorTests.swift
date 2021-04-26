@testable import FullMovies
import XCTest

class PopularMoviesServiceLocatorTests: TestCase {
    var sut: PopularMoviesServiceLocator!

    override func setUp() {
        super.setUp()
        sut = PopularMoviesServiceLocator()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testGetPopularMoviesUseCase() {
        let useCase = sut.getPopularMoviesUseCase
        XCTAssertNotNil(useCase)
    }
}

