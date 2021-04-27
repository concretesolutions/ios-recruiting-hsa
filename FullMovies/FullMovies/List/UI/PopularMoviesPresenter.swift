import Foundation

class PopularMoviesPresenter: Presenter {
    
    weak var view: BaseView?
    private let getPopularMoviesUseCase : GetPopularMoviesUseCase
    private let moviesModelMapper : Mapper<MoviesViewModel, Movies>
    
    private var popularMoviesView: PopularMoviesView? {
        return view as? PopularMoviesView
    }
    
    init (
        usecase: GetPopularMoviesUseCase,
        moviesModelMapper: Mapper<MoviesViewModel, Movies>){
        self.getPopularMoviesUseCase = usecase
        self.moviesModelMapper = moviesModelMapper
    }
    
    func load(page : String = "1"){
        self.popularMoviesView?.showLoading()
        getPopularMoviesUseCase.execute(with: page){
            result, _ in
            self.popularMoviesView?.hideLoading()
            if let result = result {
                let viewModel = self.moviesModelMapper.reverseMap(value: result)
                self.popularMoviesView?.display(popularMovies: viewModel)
            } else{
                self.popularMoviesView?.showLoading()
            }
        }
    }
}
