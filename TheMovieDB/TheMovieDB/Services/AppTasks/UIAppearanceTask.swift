import Foundation
import UIKit

class UIAppearanceTask: AppTasksProtocol {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIAppearanceService.shared.setTabBarAppearance()
        UIAppearanceService.shared.setNavigationBarAppearance()
        return true
    }
}
