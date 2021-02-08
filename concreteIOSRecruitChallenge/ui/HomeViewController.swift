//
//  HomeViewController.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 04-02-21.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var lateralScrollView: UIScrollView!
    
    //MARK: Global Variables
    
    var moviesViewController: MoviesViewController = MoviesViewController()
    var favoritesViewController: FavoritesViewController = FavoritesViewController()
    
    //MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addViewTabs()

        self.title = "Movies"
    }
    
    //MARK: Views Inits
    
    func addViewTabs(){
        var tabsAdded:CGFloat = 0
        
        self.moviesViewController.view.frame = CGRect(x: self.lateralScrollView.frame.width*tabsAdded, y: 0, width: self.view.frame.width, height: self.lateralScrollView.frame.height)
        self.addChild(self.moviesViewController)
        self.lateralScrollView.addSubview(self.moviesViewController.view)
        tabsAdded += 1
        
        self.favoritesViewController.view.frame = CGRect(x: self.lateralScrollView.frame.width*tabsAdded, y: 0, width: self.view.frame.width, height: self.lateralScrollView.frame.height)
        self.addChild(self.favoritesViewController)
        self.lateralScrollView.addSubview(self.favoritesViewController.view)
    }
}
