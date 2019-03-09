import Foundation

struct MovieModel {
    let title: String
    let overview: String
    let releaseDate: Date
    let posterPath: String
    let voteAverage: Double

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
        guard let title = entity.title, let overview = entity.overview, let releaseDateString = entity.releaseDate, let posterPath = entity.posterPath, let voteAverage = entity.voteAverage else {
            return nil
        }
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.voteAverage = voteAverage

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale.current
        if let releaseDate = dateFormatter.date(from: releaseDateString) {
            self.releaseDate = releaseDate
        } else {
            releaseDate = Date()
        }
    }
}
