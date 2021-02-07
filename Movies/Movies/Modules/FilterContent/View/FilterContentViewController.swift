//
//  FilterContentViewController.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import UIKit

class FilterContentViewController: ViewController {
    
    //MARK: - Memory debug
    
    deinit {
        print("filter content vc dealloc")
    }
    
    //MARK: - Variables
    
    var presenter: FilterContentPresenter = FilterContentPresenter()
    
    //MARK: - App lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

//MARK: - Display Logic
extension FilterContentViewController: PresenterToViewFilterContentProtocol {
    
}
