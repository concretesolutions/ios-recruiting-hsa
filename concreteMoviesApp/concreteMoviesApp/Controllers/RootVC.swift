//
//  HomeVC.swift
//  concreteMoviesApp
//
//  Created by Nebraska Melendez on 7/25/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation
import UIKit


class RootVC : UITabBarController {
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setupTabs()
    }
    

    //MARK: Setups
    private func setupView() {
      
        self.tabBar.unselectedItemTintColor = UIColor.lightGray
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = UIColor.black
        self.view.backgroundColor = .white
        self.tabBar.barTintColor = .white
        
  
    }
    
    private func setupTabs() {
        
        let moviesVC = UINavigationController(rootViewController: MoviesVC())
        let moviesItem = UITabBarItem(title: nil, image: UIImage(named: "media"), selectedImage: nil)
        moviesVC.tabBarItem = moviesItem
        
        let favoriteMoviesVC = UINavigationController(rootViewController: FavoriteMoviesVC())
        let favoriteMoviesItem = UITabBarItem(title: nil, image: UIImage(named: "like"), selectedImage: nil)
        favoriteMoviesVC.tabBarItem = favoriteMoviesItem
        
        self.viewControllers = [moviesVC, favoriteMoviesVC]
        self.selectedIndex = 0
        
    }

    
}

//MARK: Implement TabBar Controller

extension UITabBarController {
    
    
    func setTabBarVisible(visible:Bool, duration: TimeInterval, animated:Bool) {
        if (tabBarIsVisible() == visible) { return }
        let frame = self.tabBar.frame
        let height = frame.size.height
        let offsetY = (visible ? -height : height)
        
        // animation
        UIViewPropertyAnimator(duration: duration, curve: .easeIn) {
            
            self.tabBar.frame.offsetBy(dx:0, dy:offsetY)
            self.view.frame = CGRect(x:0,y:0,width: self.view.frame.width, height: self.view.frame.height + offsetY)
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
            }.startAnimation()
    }
    
    private func tabBarIsVisible() ->Bool {
        return self.tabBar.frame.origin.y < UIScreen.main.bounds.height
    }
}


