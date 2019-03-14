import Foundation

enum MovieListLocalizer: String {
    case movieListTitle = "MovieList.title"
    case tabBarItemTitle = "MovieList.tabBar.title"
    case errorAlertTitle = "MovieList.errorAlert.title"
    case errorAlertOkButton = "MovieList.errorAlert.okButton"
}

extension MovieListLocalizer {
    var localizedString: String {
        return NSLocalizedString(rawValue, tableName: "MovieList", comment: "")
    }
}
