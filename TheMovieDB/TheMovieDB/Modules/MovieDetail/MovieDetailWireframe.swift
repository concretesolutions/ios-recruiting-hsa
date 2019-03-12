import UIKit
class MovieDetailWireframe: MovieDetailWireframeProtocol {
    static func assemble() -> UIViewController {
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(interactor: interactor, router: router)
        let view = MovieDetailViewController(presenter: presenter)
        // let navigation = UINavigationController(rootViewController: view!)

        interactor.delegate = presenter
        router.viewController = view
        presenter.view = view

        return view // or navigation
    }
}
