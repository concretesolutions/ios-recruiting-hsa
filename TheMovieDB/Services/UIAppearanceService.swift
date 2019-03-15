import Foundation
import UIKit

class UIAppearanceService {
    static let shared = UIAppearanceService()

    private init() {}

    var tintColor = UIColor(red: 0.18, green: 0.19, blue: 0.27, alpha: 1.0)
    var backgroundColor = UIColor(red: 0.98, green: 0.80, blue: 0.43, alpha: 1.0)

    func setTabBarAppearance() {
        UITabBar.appearance().tintColor = tintColor
        UITabBar.appearance().backgroundColor = backgroundColor
        UITabBar.appearance().barTintColor = backgroundColor
        UITabBar.appearance().isTranslucent = false
    }

    func setNavigationBarAppearance() {
        UINavigationBar.appearance().tintColor = tintColor
        UINavigationBar.appearance().backgroundColor = backgroundColor
        UINavigationBar.appearance().barTintColor = backgroundColor
        UINavigationBar.appearance().isTranslucent = false
    }
}
