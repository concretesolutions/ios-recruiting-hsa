import UIKit
import Foundation

protocol PopularMoviesView {
    func first()
}

class PopularMoviesVC: UIViewController {
    var presenter : PopularMoviesPresenter!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.load()
    }
}

extension PopularMoviesVC : PopularMoviesView {
    func first() {
        
    }
}
