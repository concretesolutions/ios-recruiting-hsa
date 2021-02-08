//
//  MoviesViewController.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 04-02-21.
//

import UIKit

class MoviesViewController: CustomViewController, UICollectionViewDataSource, UICollectionViewDelegate, ViewModelProtocol {
    
    //MARK: Outlets

    @IBOutlet var collectionView: UICollectionView!
    
    //MARK: Global Variables
    
    private var viewModel: MoviesViewModel?
    private var dataList: [String : AnyObject]?
    
    //MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MoviesViewModel(viewDelegate: self)
        
        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        self.onLoading(self.collectionView)
        self.viewModel?.getData()
    }
    
    //MARK: Collection Management
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataList?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        return cell
    }
    
    //MARK: ViewModel Management
    
    func success(_ json: [String : AnyObject]) {
        OperationQueue.main.addOperation {
            json.count > 0 ? self.onSuccess(self.collectionView) : self.onNoData(self.collectionView)
            self.dataList = json
            self.collectionView.reloadData()
        }
    }
    func error(_ json: [String : AnyObject]) {
        OperationQueue.main.addOperation {
            self.onFailure(self.collectionView)
        }
    }
}
