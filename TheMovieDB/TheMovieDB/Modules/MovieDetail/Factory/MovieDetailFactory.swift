import Foundation

class MovieDetailFactory {

    func getRepository() -> SavedMoviesRepositoryProtocol {
        // Here I will return mocks repositories for unit / ui tests
        let dataSource = SavedMoviesDataSource(persistentContainer: CoreDataService.shared.savedAdsPersistentContainer)
        let repository = SavedMoviesRepository(dataSource: dataSource)
        return repository
    }
}
