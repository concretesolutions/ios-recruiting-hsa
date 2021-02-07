//
//  FiltersViewController.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import UIKit

class FiltersViewController: ViewController {
    
    //MARK: - Memory debug
    
    deinit {
        print("Filters vc dealloc")
    }
    
    //MARK: - Variables
    
    var presenter: FiltersPresenter = FiltersPresenter()
    
    //MARK: - App lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}


//MARK: - Display Logic

extension FiltersViewController: PresenterToViewFiltersProtocol {
    func fetchFiltersSuccessfull(_ filters: [Filter<String>]) {
        //TODO
    }
    
    func failure(_ error: Error) {
        let alert = UIAlertController(title: "ATENCION", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
