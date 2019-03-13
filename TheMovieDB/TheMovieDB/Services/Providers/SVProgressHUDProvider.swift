import Foundation
import SVProgressHUD

class SVProgressHUDProvider: HUDProvider {
    init() {
        SVProgressHUD.setMaximumDismissTimeInterval(2.0)
    }

    func shoInfowMessage(_ message: String) {
        SVProgressHUD.showInfo(withStatus: message)
    }

    func showSuccessMessage(_ message: String) {
        SVProgressHUD.showSuccess(withStatus: message)
    }

    func showError(_ errorMessage: String) {
        SVProgressHUD.showError(withStatus: errorMessage)
    }

    func showLoading() {
        SVProgressHUD.show()
    }

    func hideLoading() {
        SVProgressHUD.dismiss()
    }
}
