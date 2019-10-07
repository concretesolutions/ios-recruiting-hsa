//
//  FIltersRouter.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

class FiltersRouter: Wireframe{
    
    private(set) var viewController: FiltersViewController!
    
    init(navigation: UINavigationController, filtersList: [FilterModel], delegate: FiltersSelectionDelegate) {
        super.init(navigation: navigation)
        viewController = FiltersViewController(router: self, filtersList: filtersList, delegate: delegate)
    }
    
    override func updateNavigationTitle() {
        viewController.title = LocalizableStrings.filtersTitle.localized
    }
    
    func presentFilters(){
        navigation.pushViewController(viewController, animated: true)
    }
    
    func routeToList(_ completion: ()->()){
        navigation.popToRootViewController(animated: true)
        completion()
    }
    
    
}
