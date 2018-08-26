//
//  viewControllerExtension.swift
//  moviewsApp
//
//  Created by carlos jaramillo on 8/30/18.
//  Copyright © 2018 carlos jaramillo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    
    func showIndicator(){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let indicator = CustomIndicator(frame: CGRect(x: window.frame.midX - 15, y: window.frame.midY - 15, width: 30, height: 30))
        window.addSubview(indicator)
        window.bringSubview(toFront: indicator)
    }
    
    func hideIndicator(){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        for item in window.subviews {
            if item is CustomIndicator{
                item.removeFromSuperview()
            }
        }
    }
    
    func goToMovieDetail(movie : Movie){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "movie-detail-controller") as! MovieDetailViewController
        vc.movie = movie
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateFavoritesMovies(){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        if let tabBar = window.rootViewController as? UITabBarController{
            if let viewControllers = tabBar.viewControllers{
                if viewControllers.count > 1{
                    if let nav = viewControllers[1] as? UINavigationController{
                        if let vc = nav.viewControllers[0] as? FavoritesViewController{
                            vc.applyFilters()
                        }
                    }
                }
            }
        }
    }
}
