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
        getPopularMoviesUseCase.execute(with: page){
            result, _ in
            if let result = result {
                let viewModel = self.moviesModelMapper.reverseMap(value: result)
                print("viewModel")
                //TO DO: send view model to VC
            } else{
                print("errror")
            }
        }
    }
}
