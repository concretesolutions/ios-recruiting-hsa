import Foundation

class MovieListDataFactory {
    func getSavedMoviesRepository() -> SavedMoviesRepositoryProtocol {
        let dataSource = SavedMoviesDataSource(persistentContainer: CoreDataService.shared.savedMoviesPersistentContainer)
        let repository = SavedMoviesRepository(dataSource: dataSource)
        return repository
    }

    func getMovieDBRepository() -> MovieDBRepositoryProtocol {
        let dataSource = MovieDBCloudSource()
        let repository = MovieDBRepository(dataSource: dataSource)
        return repository
    }

    func getConfigurations() -> ConfigurationsProtocol {
        guard let configurations = Configurations() else {
            fatalError("Couldn't get app configurations")
        }
        return configurations
    }
}
