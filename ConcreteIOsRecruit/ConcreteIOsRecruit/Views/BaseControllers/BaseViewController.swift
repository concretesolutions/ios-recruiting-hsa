//
//  BaseViewController.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras on 11/19/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var searchController : UISearchController!
    var message: MessageView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
        self.setUpSearchController()
    }
    
    func setUpSearchController(){
        self.definesPresentationContext = true
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        self.navigationItem.searchController = searchController
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.hidesSearchBarWhenScrolling = true
    }
}

extension BaseViewController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        debugPrint("Be carefull! Managing searchResults on the BaseViewController")
    }
    
}

