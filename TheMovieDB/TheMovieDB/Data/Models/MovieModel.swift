import Foundation

struct MovieModel: Equatable {
    let id: Int32
    let title: String
    let overview: String
    let releaseDate: Date
    let posterPath: String
    let voteAverage: Double
    let genreIDS: [Int]

    var humanDate: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        formatter.doesRelativeDateFormatting = true

        let locale = Locale.current
        formatter.locale = locale

        return formatter.string(from: releaseDate)
    }

    init?(entity: MovieEntity) {
        guard let title = entity.title,
            let overview = entity.overview,
            let releaseDateString = entity.releaseDate,
            let posterPath = entity.posterPath,
            let voteAverage = entity.voteAverage,
            let id = entity.id,
            let genreIDS = entity.genreIDS else {
            return nil
        }
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.id = id
        self.genreIDS = genreIDS

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale.current
        if let releaseDate = dateFormatter.date(from: releaseDateString) {
            self.releaseDate = releaseDate
        } else {
            releaseDate = Date()
        }
    }

    init?(savedMovie: SavedMovie) {
        guard let title = savedMovie.title,
            let overview = savedMovie.overview,
            let posterPath = savedMovie.posterPath,
            let genresIDS = savedMovie.genresId,
            let releaseDate = savedMovie.releaseDate else {
            return nil
        }
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        voteAverage = savedMovie.voteAverage
        id = savedMovie.id
        genreIDS = genresIDS
        self.releaseDate = releaseDate
    }

    init(id: Int32,
         title: String,
         overview: String,
         releaseDate: Date,
         posterPath: String,
         voteAverage: Double,
         genreIDS: [Int]) {
        self.id = id
        self.title = title
        self.overview = overview
        self.releaseDate = releaseDate
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.genreIDS = genreIDS
    }
}
