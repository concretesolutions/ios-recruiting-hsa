import Foundation

enum MovieListLocalizer: String {
    case movieListTitle = "MovieList.title"
    case errorAlertTitle = "MovieList.errorAlert.title"
    case errorAlertOkButton = "MovieList.errorAlert.okButton"
}

extension MovieListLocalizer {
    var localizedString: String {
        return NSLocalizedString(self.rawValue, tableName: "MovieList", comment: "")
    }
}
