import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private let appTasks: AppTasksProtocol = AppTasks()

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // appTasks.application(application, didFinishLaunchingWithOptions: launchOptions)

        CoreDataService.shared.loadPersistentStores {
            OperationQueue.main.addOperation {
                let viewController = MainCoordinator.assemble()
                self.window?.rootViewController = viewController
                self.window?.makeKeyAndVisible()
            }
        }

        return true
    }

    func applicationWillResignActive(_: UIApplication) {}

    func applicationDidEnterBackground(_: UIApplication) {}

    func applicationWillEnterForeground(_: UIApplication) {}

    func applicationDidBecomeActive(_: UIApplication) {}

    func applicationWillTerminate(_: UIApplication) {}
}
