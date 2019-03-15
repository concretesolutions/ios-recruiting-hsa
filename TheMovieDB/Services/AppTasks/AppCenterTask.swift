import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import Foundation
import UIKit

class AppCenterTask: AppTasksProtocol {
    @discardableResult func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        MSAppCenter.start("88b261f6-b1b5-4e47-8825-5608dd8fb644", withServices: [MSAnalytics.self, MSCrashes.self])
        return true
    }
}
