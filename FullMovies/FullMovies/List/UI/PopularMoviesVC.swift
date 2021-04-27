import UIKit
import Foundation

class PopularMoviesVC: BaseViewController {
    private var collectionViewDataSource: PopularMoviesDataSource?
    private var collectionViewDelegate: PopularMoviesDelegate?
    var collectionView : UICollectionView?
    var popularMoviesData : MoviesViewModel?
    var movies = [MovieViewModel]()
    
    private var popularMoviesPresenter: PopularMoviesPresenter? {
        return presenter as? PopularMoviesPresenter
    }
    
    convenience init(presenter: PopularMoviesPresenter,
                     dataSource: PopularMoviesDataSource,
                     delegate: PopularMoviesDelegate){
        self.init(presenter: presenter)
        collectionViewDataSource = dataSource
        collectionViewDataSource?.popularMoviesVC = self
        collectionViewDelegate = delegate
        collectionViewDelegate?.popularMoviesVC = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popularMoviesPresenter?.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = Constants.Generic.nameApp
        prepare()
    }
    
    func prepare() {
        prepareCollectionView()
    }
    
    func prepareCollectionView() {
        
        let view = UIView()
        view.backgroundColor = .white
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 10)
        layout.itemSize = CGSize(width: Constants.CollectionCell.width, height: Constants.CollectionCell.height)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        let nibName = UINib(nibName: "MovieCollectionViewCell", bundle:nil)
        collectionView?.register(nibName, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        collectionView?.backgroundColor = UIColor.white
        collectionView?.dataSource = collectionViewDataSource
        collectionView?.delegate = collectionViewDelegate
        
        view.addSubview(collectionView ?? UICollectionView())
        self.view = view
    }
}

extension PopularMoviesVC : PopularMoviesView {
    func display(popularMovies: MoviesViewModel) {
        self.popularMoviesData = popularMovies
        self.movies = popularMovies.list
        collectionView?.reloadData()
    }
    
    func showError(){
        
    }
}
