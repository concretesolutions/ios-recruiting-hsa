import UIKit
class MovieDetailWireframe: MovieDetailWireframeProtocol {
    static func assemble(movie: MovieModel) -> UIViewController {
        let repository = MovieDetailFactory().getRepository()
        let interactor = MovieDetailInteractor(repository: repository)
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(interactor: interactor, router: router)
        let storyboard = UIStoryboard(name: "MovieDetail", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController

        view.model = movie
        view.presenter = presenter

        interactor.delegate = presenter
        router.viewController = view
        presenter.view = view

        return view
    }
}
