import UIKit

class BaseViewController: UIViewController, BaseView {
    private(set) var presenter: Presenter?
    
    convenience init(presenter: Presenter) {
        self.init()
        self.presenter = presenter
    }
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        presenter?.attach(view: self)
        edgesForExtendedLayout = UIRectEdge()
        extendedLayoutIncludesOpaqueBars = false
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: Constants.Generic.empty,
            style: .plain,
            target: nil,
            action: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarTheme()
    }
    
    func showLoading() {
    }
    
    func hideLoading() {
    }
    
    func setNavigationBarTheme() {
        navigationController?.navigationBar.barTintColor = .yellow
        navigationController?.navigationBar.tintColor = .white
    }
}
