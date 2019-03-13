import UIKit

class MovieListWireframe: MovieListWireframeProtocol {
    static func assemble() -> UIViewController {
        let factory = MovieListDataFactory()
        let interactor = MovieListInteractor(savedMoviesRepository: factory.getSavedMoviesRepository(), movieDBRepository: factory.getMovieDBRepository(), configurations: factory.getConfigurations())
        let router = MovieListRouter()
        let presenter = MovieListPresenter(interactor: interactor, router: router)
        let view = MovieListViewController(presenter: presenter)

        interactor.delegate = presenter
        router.viewController = view
        presenter.view = view

        return view
    }
}
