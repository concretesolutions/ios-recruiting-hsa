//
//  AppNavigationDelegate.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/11/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

class AppNavigationInterceptor: NSObject, UINavigationControllerDelegate{
    
    weak var coordinator: Coordinator?
    weak var interceptController: UIViewController?
    
    init(coordinator: Coordinator, interceptController: UIViewController){
        self.coordinator = coordinator
        self.interceptController = interceptController
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if fromViewController == interceptController{
            coordinator?.stop()
        }
    }
    
}
