//
//  MoviesViewController.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 04-02-21.
//

import UIKit

class MoviesViewController: CustomViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MovieViewModelProtocol, UISearchBarDelegate {
    
    //MARK: Outlets

    @IBOutlet var collectionView: UICollectionView?
    @IBOutlet var seachBar: UISearchBar!
    
    //MARK: Global Variables
    
    private var viewModel: MoviesViewModel?
    private var dataList: [MovieEntry?] = []
    private var filterList: [MovieEntry?] = []
    private var page = 0
    var delegate: MoviesViewControllerProtocol?
    
    //MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MoviesViewModel(viewDelegate: self)
        self.loadMoreData()
        
        if let collection = self.collectionView{
            let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
                collection.register(nib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
            let nib2 = UINib(nibName: "GeneralLoadMoreCollectionViewCell", bundle: nil)
                collection.register(nib2, forCellWithReuseIdentifier: "GeneralLoadMoreCollectionViewCell")
            
            self.onLoading(collection)
        }
    }
    
    //MARK: Collection Management
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filterList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(filterList[indexPath.row] == nil){
            let cell: GeneralLoadMoreCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GeneralLoadMoreCollectionViewCell", for: indexPath) as! GeneralLoadMoreCollectionViewCell
            
            self.loadMoreData()
            
            return cell
        }
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        cell.loadCellView(movieEntry: self.filterList[indexPath.row], viewModel: self.viewModel, delegate: self.delegate)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width*0.49, height: self.view.frame.width*0.70)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        OperationQueue.main.addOperation {
            let viewController = MovieDetailViewController()
            viewController.data = self.filterList[indexPath.row]
            
            self.navigationController!.pushViewController(viewController, animated: true)
        }
    }
    
    //MARK: Data Management
    
    private func loadMoreData(){
        self.page += 1
        self.viewModel?.getData(params: ["page": self.page.description])
    }
    @IBAction func reloadData(){
        self.seachBar.text = ""
        self.page -= 1
        self.loadMoreData()
    }
    
    //MARK: ViewModel Management
    
    func success(_ json: GeneralHeaderEntry<MovieEntry>?) {
        OperationQueue.main.addOperation {
            if let collection = self.collectionView{
                json?.success == true ? json?.results?.count ?? 0 > 0 ? self.onSuccess(collection) : self.onNoData(collection) : self.onFailure(collection)
                self.dataList = self.dataList.filter { $0 != nil }
                self.dataList.append(contentsOf: json?.results ?? [])
                if(json?.total_pages ?? 0 > self.page) { self.dataList.append(nil) }
                self.filterList = self.dataList
                collection.reloadData()
            }
        }
    }
    func error() {
        OperationQueue.main.addOperation {
            if let collection = self.collectionView{ self.onFailure(collection) }
        }
    }
    
    //MARK: SearchBar Management
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if let seachText = searchBar.text{
            if(searchBar.text != ""){
                self.filterList = self.dataList.filter { $0 != nil }
                self.filterList = self.filterList.filter {($0!.title!.lowercased().contains(seachText.lowercased()))}
                
            }else{
                self.filterList = self.dataList
            }
            if let collection = self.collectionView{
                if (self.filterList.count > 0){
                    self.onSuccess(collection)
                }else{
                    self.onNoData(collection)
                    self.reloadButton?.isHidden = true
                }
                collection.reloadData()
            }
        }
    }
}
protocol MoviesViewControllerProtocol: class{
    func reloadFavoriteList()
}
