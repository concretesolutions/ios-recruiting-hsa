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
                let dataSource = SavedMoviesDataSource(persistentContainer: CoreDataService.shared.savedAdsPersistentContainer)
                let repository = SavedMoviesRepository(dataSource: dataSource)

                let movie = MovieModel(id: 1,
                                       title: "Capitana Marvel",
                                       overview: "La historia sigue a Carol Danvers mientras ella se convierte en uno de los héroes más poderosos del universo cuando la Tierra se encuentre atrapada en medio de una guerra galáctica entre dos razas alienígenas. Situada en los años 90, Captain Marvel es una historia nueva de un período de tiempo nunca antes visto en la historia del Universo Cinematográfico de Marvel.",
                                       releaseDate: Date(), // 2019-03-06
                                       posterPath: "/d3p5JuwN7dG0TvrN5h4ZY4tMOEX.jpg",
                                       voteAverage: 7.3,
                                       genreIDS: [
                                        28,
                                        12,
                                        878
                    ])

                let viewController = MovieDetailWireframe.assemble(repository: repository, movie: movie)
                self.window?.rootViewController = viewController
                self.window?.makeKeyAndVisible()
            }
        }

        return true
    }

    func applicationWillResignActive(_: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
