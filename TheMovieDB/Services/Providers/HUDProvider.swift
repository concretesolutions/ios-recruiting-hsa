import Foundation

protocol HUDProvider {
    func shoInfowMessage(_ message: String)
    func showSuccessMessage(_ message: String)
    func showError(_ errorMessage: String)
    func showLoading()
    func hideLoading()
}
