import Foundation
import UIKit


class CoreDataTask: AppTasksProtocol {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool? {
        CoreDataService.shared.loadPersistentStores()
        return nil
    }
}
