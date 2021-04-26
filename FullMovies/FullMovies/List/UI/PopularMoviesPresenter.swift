import Foundation

class PopularMoviesPresenter {
    
    let view : PopularMoviesView
    private let getPopularMoviesUseCase : GetPopularMoviesUseCase
    private let moviesModelMapper : Mapper<MoviesViewModel, Movies>
    
    init (
        view : PopularMoviesView,
        usecase: GetPopularMoviesUseCase,
        moviesModelMapper: Mapper<MoviesViewModel, Movies>){
        self.view = view
        self.getPopularMoviesUseCase = usecase
        self.moviesModelMapper = moviesModelMapper
    }
    
    func load(page : String = "1"){
        getPopularMoviesUseCase.execute(with: page){
            result, _ in
            if let result = result {
                let viewModel = self.moviesModelMapper.reverseMap(value: result)
                //TO DO: send view model to VC
            } else{
                print("error")
            }
        }
    }
}
