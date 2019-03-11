import Foundation
import UIKit

class CoreDataTask: AppTasksProtocol {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool? {
        CoreDataService.shared.loadPersistentStores()
        return nil
    }
}
