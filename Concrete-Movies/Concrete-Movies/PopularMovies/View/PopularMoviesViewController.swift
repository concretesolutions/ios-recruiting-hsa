//
//  PopularMoviesViewController.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/27/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var searchActive : Bool = false
    
    private var datasource: PopularMoviesDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepare()
    }
    
    convenience init(datasource: PopularMoviesDataSource) {
        self.init()
        datasource.viewController = self
        self.datasource = datasource
    }

    private func prepare(){
        prepareCoplllectionView()
        prepareSearchBar()
    }
    
    private func prepareCoplllectionView(){
        //moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = datasource
        
        moviesCollectionView.register(
            UINib(nibName: PopularMoviesConstants.moviesCellNibName, bundle: nil),
            forCellWithReuseIdentifier: PopularMoviesConstants.movieCellIdentifier
        )
    }
    
    private func prepareSearchBar(){
        moviesSearchBar.backgroundColor = Colors.Primary.accent
        moviesSearchBar.delegate = self
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

extension PopularMoviesViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        /*filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
         */
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
}

extension PopularMoviesViewController: UICollectionViewDelegate{
    
}
