//
//  HomeViewController.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 04-02-21.
//

import UIKit

class HomeViewController: UIViewController, UITabBarDelegate, MoviesViewControllerProtocol, GenreProtocol {
    
    //MARK: Outlets
    
    @IBOutlet weak var lateralScrollView: UIScrollView!
    @IBOutlet weak var tabBar: UITabBar!
    
    //MARK: Global Variables
    
    private var viewModel: HomeViewModel?
    var moviesViewController: MoviesViewController = MoviesViewController()
    var favoritesViewController: FavoritesViewController = FavoritesViewController()
    
    //MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async { self.addViewTabs() }
        self.title = "Movies"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel = HomeViewModel(viewDelegate: self)
        self.viewModel?.getData()
        self.favoritesViewController.loadData()
        self.moviesViewController.collectionView?.reloadData()
    }
    
    //MARK: Views Inits
    
    func addViewTabs(){
        self.tabBar.selectedItem = self.tabBar.items?[0]
        var tabsAdded: CGFloat = 0
        
        self.moviesViewController.view.frame = CGRect(x: self.view.frame.width * tabsAdded, y: 0, width: self.view.frame.width, height: self.lateralScrollView.frame.height)
        self.addChild(self.moviesViewController)
        self.moviesViewController.delegate = self
        self.lateralScrollView.addSubview(self.moviesViewController.view)
        tabsAdded += 1
        
        self.favoritesViewController.view.frame = CGRect(x: self.view.frame.width * tabsAdded, y: 0, width: self.view.frame.width, height: self.lateralScrollView.frame.height)
        self.addChild(self.favoritesViewController)
        self.lateralScrollView.addSubview(self.favoritesViewController.view)
        
        self.lateralScrollView.contentSize = CGSize(width: self.view.frame.width*2, height: self.lateralScrollView.frame.height)
    }
    
    //MARK: TabBar Management
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
        self.lateralScrollView.scrollRectToVisible(CGRect(x: self.view.frame.width*CGFloat(item.tag - 1), y: 0, width: self.view.frame.width, height: self.lateralScrollView.frame.height), animated: false)
    }
    func reloadFavoriteList() {
        self.favoritesViewController.loadData()
    }
    
    //MARK: GenreProtocol Management
    
    func success(_ json: [GenreEntry]?) {
        self.moviesViewController.genreList = json
    }
    func error() {}
}
