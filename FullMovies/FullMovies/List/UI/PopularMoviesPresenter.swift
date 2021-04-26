import Foundation

class PopularMoviesPresenter {
    
    let view : PopularMoviesView
    private let getPopularMoviesUseCase : GetPopularMoviesUseCase
    
    init (view : PopularMoviesView, usecase: GetPopularMoviesUseCase){
        self.view = view
        self.getPopularMoviesUseCase = usecase
        //TO DO: add mapper
    }
    
    func load(page : String = "1"){
        getPopularMoviesUseCase.execute(with: page){
            movies, _ in
            if let listMovies = movies?.list {
                print("trying")
            }
            else{
                print("errror")
            }
        }
    }
}
