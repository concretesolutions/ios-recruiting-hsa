import UIKit

class SavedMoviesWireframe: SavedMoviesWireframeProtocol {
    static func assemble() -> UIViewController {
        let factory = SavedMoviesDataFactory()
        let interactor = SavedMoviesInteractor(savedMoviesRepository: factory.getSavedMoviesRepository())
        let router = SavedMoviesRouter()
        let presenter = SavedMoviesPresenter(interactor: interactor, router: router)

        let storyboard = UIStoryboard(name: "SavedMovies", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SavedMoviesViewController") as! SavedMoviesViewController
        let navigation = UINavigationController(rootViewController: view)

        view.presenter = presenter
        view.configurations = factory.getConfigurations()
        view.hudProvider = factory.getHUDProvider()

        interactor.delegate = presenter
        router.viewController = view
        router.navigationController = navigation
        presenter.view = view

        return navigation
    }
}
