import UIKit

class BaseViewController: UIViewController, BaseView {
    private(set) var presenter: Presenter?
    private let activityIndicator = UIActivityIndicatorView()
    
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

   
    
    //MARK: - Private Methods -
    private func setupLoader() {
        hideLoading()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .gray
    }
    
    private func setNavigationBarTheme() {
        navigationController?.navigationBar.barTintColor = .yellow
        navigationController?.navigationBar.tintColor = .white
    }

    //MARK: - Actions Activity Indicator
    
    func showLoading() {
        setupLoader()

        DispatchQueue.main.async {
            self.activityIndicator.center = self.view.center
            self.activityIndicator.startAnimating()
            self.view.addSubview(self.activityIndicator)
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }

    func hideLoading(){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}
