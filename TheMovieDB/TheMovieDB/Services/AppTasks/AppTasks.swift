import Foundation
import UIKit

class AppTasks: AppTasksProtocol {
    private let tasks: [AppTasksProtocol] = [
        CoreDataTask()
    ]

    @discardableResult func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        tasks.forEach({ $0.application(application, didFinishLaunchingWithOptions: launchOptions) })
        return true
    }
}
