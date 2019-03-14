import Foundation
@testable import TheMovieDB
import XCTest

class MovieDetailInteractorMockDelegate: MovieDetailInteractorDelegate {
    var functionsCalled = [String]()
    var expect: XCTestExpectation?
    var savedStatus = false

    func saveMovieSuccess() {
        functionsCalled.append(#function)
        expect?.fulfill()
    }

    func saveMovieFailure(error _: Error) {
        functionsCalled.append(#function)
        expect?.fulfill()
    }

    func unsaveMovieSuccess() {
        functionsCalled.append(#function)
        expect?.fulfill()
    }

    func unsaveMovieFailure(error _: Error) {
        functionsCalled.append(#function)
        expect?.fulfill()
    }

    func savedMovieStatusFetched(saved: Bool) {
        functionsCalled.append(#function)
        savedStatus = saved
        expect?.fulfill()
    }
}
