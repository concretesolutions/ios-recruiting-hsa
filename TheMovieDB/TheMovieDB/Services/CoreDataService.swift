import CoreData
import Foundation

class CoreDataService {
    static let shared = CoreDataService()
    private let logCategory = "TheMovieDB-CoreData"

    private(set) var savedMoviesPersistentContainer: NSPersistentContainer
    private let savedAdsDatabaseName = "SavedMovies"

    private init() {
        savedMoviesPersistentContainer = NSPersistentContainer(name: savedAdsDatabaseName)
        initSavedAdsContainer()
    }

    private func initSavedAdsContainer() {
        guard let libraryPath = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first else { return }
        let savedAdsStoreUrl = libraryPath
            .appendingPathComponent("saved-movies")
            .appendingPathExtension("data")

        let description = NSPersistentStoreDescription()
        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true
        description.type = NSBinaryStoreType
        description.url = savedAdsStoreUrl
        savedMoviesPersistentContainer.persistentStoreDescriptions = [description]
    }

    func loadPersistentStores(success: @escaping () -> Void) {
        savedMoviesPersistentContainer.loadPersistentStores { description, error in
            if let error = error {
                LogProvider.shared.log(message: "Error getting saved movies core data stores %@", type: .error, logCategory: self.logCategory, args: String(describing: error))
                // LogProvider.shared.logNonFatal(error: error)
            } else {
                LogProvider.shared.log(message: "Saved movies core data stack loaded: %@", type: .info, logCategory: self.logCategory, args: String(describing: description))
                success()
            }
        }
    }
}
