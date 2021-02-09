//
//  MoviesViewController.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 04-02-21.
//

import UIKit

class MoviesViewController: CustomViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MovieViewModelProtocol {
    
    //MARK: Outlets

    @IBOutlet var collectionView: UICollectionView!
    
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
        
        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        let nib2 = UINib(nibName: "GeneralLoadMoreCollectionViewCell", bundle: nil)
        self.collectionView.register(nib2, forCellWithReuseIdentifier: "GeneralLoadMoreCollectionViewCell")
        
        self.onLoading(self.collectionView)    }
    
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
        self.page -= 1
        self.loadMoreData()
    }
    
    //MARK: ViewModel Management
    
    func success(_ json: GeneralHeaderEntry<MovieEntry>?) {
        OperationQueue.main.addOperation {
            json?.success == true ? json?.results?.count ?? 0 > 0 ? self.onSuccess(self.collectionView) : self.onNoData(self.collectionView) : self.onFailure(self.collectionView)
            self.dataList = self.dataList.filter { $0 != nil }
            self.dataList.append(contentsOf: json?.results ?? [])
            if(json?.total_pages ?? 0 > self.page) { self.dataList.append(nil) }
            self.filterList = self.dataList
            self.collectionView.reloadData()
        }
    }
    func error() {
        OperationQueue.main.addOperation {
            self.onFailure(self.collectionView)
        }
    }
}
protocol MoviesViewControllerProtocol: class{
    func reloadFavoriteList()
}
