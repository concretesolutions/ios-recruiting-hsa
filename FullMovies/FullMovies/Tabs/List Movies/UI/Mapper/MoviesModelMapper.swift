import Foundation

class MoviesModelMapper: Mapper<MoviesViewModel, Movies> {
    override func reverseMap(value: Movies) -> MoviesViewModel {
        let pageString = "\(value.page ?? .zero)"
        return MoviesViewModel(
            pageNumber: value.page ?? .zero,
            page: pageString,
            list: createMovieListViewModel(from: value.list ?? []),
            totalPages: value.totalPages ?? .zero
        )
    }
    
    private func createMovieListViewModel(from values: [MovieInfo]) -> [MovieViewModel] {
        var moviesList = [MovieViewModel]()
        
        for movieInfo in values {
            let movie = createMovieViewModel(from: movieInfo)
            moviesList.append(movie)
        }
        return moviesList
    }
    
    func createMovieViewModel(from value : MovieInfo) ->  MovieViewModel {
        
        let release = value.releaseDate ?? Constants.Generic.empty
        let index = release.index(release.startIndex, offsetBy: 4)
        let year = String(release[..<index])
        
        return MovieViewModel(
            title: value.title ?? Constants.Generic.empty,
            overview: value.overview ?? Constants.Generic.empty,
            year: year ,
            poster: value.posterPath ?? Constants.Generic.empty)
    }
}
