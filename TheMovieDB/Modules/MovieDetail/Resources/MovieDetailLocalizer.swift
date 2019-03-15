import Foundation

enum MovieDetailLocalizer: String {
    case cellTitle = "MovieDetail.cell.title"
    case cellAverage = "MovieDetail.cell.average"
    case cellOverview = "MovieDetail.cell.overview"
    case cellDate = "MovieDetail.cell.date"
    case cellGenres = "MovieDetail.cell.genres"
    case cellOverviewNoData = "MovieDetail.cell.overview.noData"

    case saveMovieSuccessMessage = "MovieDetail.saveMovie.success"
    case unsaveMovieSuccessMessage = "MovieDetail.unsaveMovie.success"

    case errorAlertSaveMovieMessage = "MovieDetail.errorAlert.saveMovie.message"
    case errorAlertUnsaveMovieMessage = "MovieDetail.errorAlert.unsaveMovie.message"
    case errorAlertTitle = "MovieDetail.errorAlert.title"
    case errorAlertOkButtonTitle = "MovieDetail.errorAlert.okButton"
}

extension MovieDetailLocalizer {
    var localizedString: String {
        return NSLocalizedString(rawValue, tableName: "MovieDetail", comment: "")
    }
}
