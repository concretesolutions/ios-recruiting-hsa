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
    private var dataList: [MovieEntry]?
    
    //MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MoviesViewModel(viewDelegate: self)
        self.viewModel?.getData()
        
        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        self.onLoading(self.collectionView)
    }
    
    //MARK: Collection Management
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataList?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        cell.loadCellView(movieEntry: dataList?[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width*0.49, height: self.view.frame.width*0.70)
    }
    
    //MARK: ViewModel Management
    
    func success(_ json: GeneralHeaderEntry<MovieEntry>?) {
        OperationQueue.main.addOperation {
            json?.results?.count ?? 0 > 0 ? self.onSuccess(self.collectionView) : self.onNoData(self.collectionView)
            self.dataList = json?.results
            self.collectionView.reloadData()
        }
    }
    func error() {
        OperationQueue.main.addOperation {
            self.onFailure(self.collectionView)
        }
    }
}
