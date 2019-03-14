import Foundation
@testable import TheMovieDB

class MovieDetailMockInteractor: MovieDetailInteractorProtocol {
    var functionsCalled = [String]()

    weak var delegate: MovieDetailInteractorDelegate?

    func saveMovie(_: MovieModel) {
        functionsCalled.append(#function)
    }

    func unsaveMovie(_: MovieModel) {
        functionsCalled.append(#function)
    }

    func fetchSavedStatus(movieId _: Int32) {
        functionsCalled.append(#function)
    }
}
