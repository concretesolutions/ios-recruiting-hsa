import Foundation

protocol Presenter: class {
    var view: BaseView? { get set }

    func attach(view: BaseView)
    func dettach()
}

extension Presenter {
    func attach(view: BaseView) {
        self.view = view
        view.prepare()
    }

    func dettach() {
        view = nil
    }
}
