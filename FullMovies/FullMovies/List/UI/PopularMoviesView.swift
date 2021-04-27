protocol PopularMoviesView : BaseView{
    func display(popularMovies : MoviesViewModel)
    func showError()
    
    var movies: [MovieViewModel] { get }
}
