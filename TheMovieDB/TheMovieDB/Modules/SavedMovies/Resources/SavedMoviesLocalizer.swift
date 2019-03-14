import Foundation

enum SavedMoviesLocalizer: String {
    case savedMoviesViewTitle = "SavedMovies.title"
    case savedMoviesTabBarItemTitle = "SavedMovies.tabbar.title"
    case cellUnsave = "SavedMovies.cell.delete"
    case unsaveSuccessfull = "SavedMovies.unsaveAction.success"
}

extension SavedMoviesLocalizer {
    var localizedString: String {
        return NSLocalizedString(rawValue, tableName: "SavedMovies", comment: "")
    }
}
