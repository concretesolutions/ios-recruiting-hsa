import Foundation
import UIKit
@testable import TheMovieDB

class MovieDetailMockRouter: MovieDetailRouterProtocol {
    var functionsCalled = [String]()
    var viewController: UIViewController?

    func showErrorAlert(error _: Error, isSave _: Bool) {
        functionsCalled.append(#function)
    }

    func dismiss() {
        functionsCalled.append(#function)
    }
}
