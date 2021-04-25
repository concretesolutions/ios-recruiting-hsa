import Foundation
@testable import FullMovies

class PopularMoviesRepositoryMock: PopularMoviesRepository {
    var success = false
    
    func list(with key: String, completionHandler: @escaping (Movies?, ErrorModel?) -> Void) {
        if success {
            let movie = movieInfoModel()
            let model = Movies(
                page: 1,
                list: [movie],
                totalPages: 1,
                totalResults: 1
            )
            completionHandler(model, nil)
        }
        else {
            completionHandler(nil, errorModel())
        }
    }
    
    private func movieInfoModel() -> MovieInfo {
        return MovieInfo(
            adult: false,
            backdropPath: "/9yBVqNruk6Ykrwc32qrK2TIE5xw.jpg",
            genreIds: [14,28],
            id: 460465,
            originalLanguage: "en",
            originalTitle: "Mortal Kombat",
            overview: "Washed-up MMA fighter Cole Young, unaware of his heritage, and hunted by Emperor Shang Tsung's best warrior, Sub-Zero, seeks out and trains with Earth's greatest champions as he prepares to stand against the enemies of Outworld in a high stakes battle for the universe.",
            popularity: 4901.131,
            posterPath: "/2xmx8oPlbDaxTjHsIOZvOt5L3aJ.jpg",
            releaseDate: "2021-04-0",
            title: "Mortal Kombat",
            video: false,
            voteAverage: 8.1,
            voteCount: 980)
    }
    
    private func errorModel() -> ErrorModel {
        return ErrorModel(
            statusMessage: "Fail",
            statusCode: 400
        )
    }
}
