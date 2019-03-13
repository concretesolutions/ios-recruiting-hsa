import UIKit

class MovieListWireframe: MovieListWireframeProtocol {
    static func assemble(savedMoviesRepository: SavedMoviesRepositoryProtocol, movieDBRepository: MovieDBRepositoryProtocol, configurations: ConfigurationsProtocol) -> UIViewController {
        let interactor = MovieListInteractor(savedMoviesRepository: savedMoviesRepository, movieDBRepository: movieDBRepository, configurations: configurations)
        let router = MovieListRouter()
        let presenter = MovieListPresenter(interactor: interactor, router: router)
        let view = MovieListViewController(presenter: presenter)

        interactor.delegate = presenter
        router.viewController = view
        presenter.view = view

        return view
    }
}
