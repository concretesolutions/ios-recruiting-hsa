import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import Foundation
import UIKit

class AppCenterTask: AppTasksProtocol {
    @discardableResult func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        MSAppCenter.start("e5413e95-dd59-4756-8723-5163085f2247", withServices: [MSAnalytics.self, MSCrashes.self])
        return true
    }
}
