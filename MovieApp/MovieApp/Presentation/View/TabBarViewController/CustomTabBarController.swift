//
//  CustomTabBarController.swift
//  MovieApp
//
//  Created by luis.a.rosas.arce on 21/01/19.
//  Copyright © 2019 luis.a.rosas.arce. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var tabBarItem = UITabBarItem()
        UITabBar.appearance().barTintColor = UIColor(red: 246.0/255.0, green: 206.0/255.0, blue: 91.0/255.0, alpha: 1.0)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.darkGray], for: .normal)
        
        
        let movieImage = UIImage(named: "list_icon")?.withRenderingMode(.alwaysOriginal)
        let movieImageSelected = UIImage(named: "list_icon")?.withRenderingMode(.alwaysOriginal)
        tabBarItem = self.tabBar.items![0]
        tabBarItem.image = movieImage
        tabBarItem.selectedImage = movieImageSelected
        
        let favoriteImage = UIImage(named: "favorite_empty_icon")?.withRenderingMode(.alwaysOriginal)
        let favoriteImageSelected = UIImage(named: "favorite_empty_icon")?.withRenderingMode(.alwaysOriginal)
        tabBarItem = self.tabBar.items![1]
        tabBarItem.image = favoriteImage
        tabBarItem.selectedImage = favoriteImageSelected
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
