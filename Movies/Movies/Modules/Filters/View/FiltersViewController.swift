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
    
}
