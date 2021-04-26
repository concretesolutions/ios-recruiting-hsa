@testable import FullMovies
import XCTest

class UrlHelperTests: TestCase {
    var sut: UrlHelper!

    override func setUp() {
        super.setUp()
        sut = UrlHelper()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testUrlForSimulation() {
        let url = sut.url(for: .popularMovies)
        let version = "/3"
        XCTAssertEqual(url, NetworkConstants.Endpoint.base.rawValue + version + NetworkConstants.Endpoint.popularMovies.rawValue)
    }
}
