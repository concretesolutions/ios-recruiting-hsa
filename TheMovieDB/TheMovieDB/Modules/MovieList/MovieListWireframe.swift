import UIKit

class MovieListWireframe: MovieListWireframeProtocol {
    static func assemble() -> UIViewController {
        let factory = MovieListDataFactory()
        let interactor = MovieListInteractor(savedMoviesRepository: factory.getSavedMoviesRepository(), movieDBRepository: factory.getMovieDBRepository(), configurations: factory.getConfigurations())
        let router = MovieListRouter()
        let presenter = MovieListPresenter(interactor: interactor, router: router)
        let storyboard = UIStoryboard(name: "MovieList", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
        view.configurations = factory.getConfigurations()
        view.presenter = presenter

        let navigation = UINavigationController(rootViewController: view)

        interactor.delegate = presenter
        router.viewController = view
        router.navigationController = navigation
        presenter.view = view

        return navigation
    }
}
