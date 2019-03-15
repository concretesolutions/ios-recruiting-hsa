import Foundation
@testable import TheMovieDB

class MovieDetailMockView: MovieDetailViewProtocol {
    var presenter: MovieDetailPresenterProtocol?
    var model: MovieModel?
    var functionsCalled = [String]()

    func showLoading() {
        functionsCalled.append(#function)
    }

    func hideLoading() {
        functionsCalled.append(#function)
    }

    func showMessage(_: String) {
        functionsCalled.append(#function)
    }

    func updateSavedMovieStatus(saved _: Bool) {
        functionsCalled.append(#function)
    }
}
