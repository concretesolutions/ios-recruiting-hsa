import UIKit
class MovieDetailWireframe: MovieDetailWireframeProtocol {
    static func assemble(movie: MovieModel, genres: [String], savedAdsDelegate: MovieListSavedAdsUpdate?) -> UIViewController {
        let factory = MovieDetailFactory()
        let repository = factory.getSavedMoviesRepository()
        let interactor = MovieDetailInteractor(repository: repository)
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(interactor: interactor, router: router)
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController

        view.model = movie
        view.presenter = presenter
        view.hudProvider = factory.getHUDProvider()
        view.genres = genres
        view.configurations = factory.getConfigurations()
        view.savedAdsDelegate = savedAdsDelegate

        interactor.delegate = presenter
        router.viewController = view
        presenter.view = view

        return view
    }
}
