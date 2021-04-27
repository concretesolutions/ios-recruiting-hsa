import UIKit
import Foundation

class PopularMoviesVC: BaseViewController {
    private var collectionViewDataSource: PopularMoviesDataSource?
    private var collectionViewDelegate: PopularMoviesDelegate?
    var collectionView : UICollectionView?
    var moviesData : MoviesViewModel?
    
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
        prepare()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Full Movies"
        popularMoviesPresenter?.load()
    }
    
    func prepare() {
        prepareCollectionView()
    }
    
    func prepareCollectionView() {
        
        let view = UIView()
        view.backgroundColor = .white
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionView?.backgroundColor = UIColor.white
        collectionView?.dataSource = collectionViewDataSource
        collectionView?.delegate = collectionViewDelegate
        
        view.addSubview(collectionView ?? UICollectionView())
        self.view = view
    }
}

extension PopularMoviesVC : PopularMoviesView {
    func display(movies: MoviesViewModel) {
        self.moviesData = movies
    }
}
