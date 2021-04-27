protocol PopularMoviesView : BaseView{
    func display(popularMovies : MoviesViewModel)
    func select(index: Int)
    func showError()
    func showMovieDetails(to movie : MovieViewModel)
    
    var movies: [MovieViewModel] { get }
}
