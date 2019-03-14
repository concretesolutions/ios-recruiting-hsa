import Foundation

class MovieDetailFactory {
    func getSavedMoviesRepository() -> SavedMoviesRepositoryProtocol {
        // Here I will return mocks repositories for unit / ui tests
        let dataSource = SavedMoviesDataSource(persistentContainer: CoreDataService.shared.savedMoviesPersistentContainer)
        let repository = SavedMoviesRepository(dataSource: dataSource)
        return repository
    }

    func getHUDProvider() -> HUDProvider {
        return SVProgressHUDProvider()
    }

    func getConfigurations() -> ConfigurationsProtocol {
        guard let configurations = Configurations() else {
            fatalError("Couldn't get app configurations")
        }
        return configurations
    }
}
