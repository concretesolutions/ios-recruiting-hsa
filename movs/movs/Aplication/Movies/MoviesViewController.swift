//
//  MoviesViewController.swift
//  movs
//
//  Created by Carlos Petit on 13-03-21.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func FavButtonPress(_ sender: UIButton) {
        viewModel.favorite(at: Int(sender.tag))
        let isFavorite = viewModel.item(at: Int(sender.tag)).favorite
        sender.setImage(UIImage(systemName: isFavorite ? "heart.fill":"heart"), for: .normal)
    }
    var favButton = UIButton(frame: CGRect(x: 151, y: 214, width: 37, height: 30))
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 400, height: 20))
    private var viewModel = MoviesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        let leftNavBarButton = UIBarButtonItem(customView: searchBar)
        
        searchBar.placeholder = "Busqueda"
        self.navigationItem.title = ""
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}


extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = viewModel.numbersOfItems
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold, scale: .large)
        
        self.favButton = UIButton(frame: CGRect(x: 145, y: 190, width: 37, height: 30))
        let isFavorite = viewModel.item(at: indexPath).favorite
        print("Aerssss",indexPath.row, isFavorite)
        
        self.favButton.setImage(UIImage(systemName: isFavorite ? "heart.fill":"heart", withConfiguration: largeConfig), for: .normal)
        cell.setUp(with: viewModel.item(at: indexPath), indexPath: indexPath.row)
       
        
        self.favButton.tintColor = UIColor.white
        self.favButton.addTarget(self, action: #selector(FavButtonPress), for: UIControl.Event.touchUpInside)
        self.favButton.tag = indexPath.row
        self.favButton.isUserInteractionEnabled = true
        cell.addSubview(self.favButton)
        return cell
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print((self.view.frame.size.width/2))
        return CGSize(width: (self.view.frame.size.width/2)-10, height: (self.view.frame.size.width/2 + 30))
//        ((self.view.frame.size.width/3) - 16, )
    }
}

extension MoviesViewController: MoviesViewModeldelegate{
    func reloadData() {
        collectionView.reloadData()
    }
}


extension MoviesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.searchBar.endEditing(true)
        let sampleStoryBoard : UIStoryboard = UIStoryboard(name: "MovieStoryBoard", bundle:nil)
        let detailMovieViewController  = sampleStoryBoard.instantiateViewController(identifier: "DetailMovieViewController") as! DetailMovieViewController
        detailMovieViewController.selectedMovieIndex = indexPath.row
        detailMovieViewController.selectedMovie = viewModel.item(at: indexPath)
        detailMovieViewController.ModelView = viewModel
        self.navigationController?.pushViewController(detailMovieViewController, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.endEditing(true)
    }
}
