import Foundation

protocol BaseView: class {
    func prepare()
    func showLoading()
    func hideLoading()
}

extension BaseView {
    func prepare() {}

    func showLoading() {}

    func hideLoading() {}
}
