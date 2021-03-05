//
//  TabCoordinator.swift
//  Movies
//
//  Created by Daniel Nunez on 03-03-21.
//

import UIKit

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    func selectPage(_ page: TabBarPage)
    func setSelectedIndex(_ index: Int)
    func currentPage() -> TabBarPage?
}

class TabCoordinator: NSObject, Coordinator {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController: UITabBarController

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }

    func start() {
        let pages: [TabBarPage] = [.movies, .favorites]
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        setupAppearance()
        prepareTabBarController(withTabControllers: controllers)
    }

    func setupAppearance() {
        UITabBar.appearance().tintColor = .systemYellow
        UITabBar.appearance().unselectedItemTintColor = .darkGray
    }

    deinit {
        print("TabCoordinator deinit")
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.movies.order()
        tabBarController.tabBar.isTranslucent = false

        navigationController.viewControllers = [tabBarController]
    }

    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(true, animated: false)
        navController.tabBarItem = UITabBarItem.init(title: page.title(),
                                                     image: page.icon(),
                                                     tag: page.order())

        let movieCoordinator = MovieCoordinator(navigationController: navController)
        switch page {
        case .movies:
            movieCoordinator.start()

        case .favorites:
            movieCoordinator.showFavorites()
        }

        childCoordinators.append(movieCoordinator)

        return navController
    }

    func currentPage() -> TabBarPage? { TabBarPage.init(index: tabBarController.selectedIndex) }

    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.order()
    }

    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }

        tabBarController.selectedIndex = page.order()
    }
}
