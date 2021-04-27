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
        title = Constants.ViewTitle.movies
        popularMoviesPresenter?.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepare()
    }
    
    func prepare() {
        prepareCollectionView()
    }
    
    func prepareCollectionView() {
        
        let view = UIView()
        view.backgroundColor = .white
        
        let sizeCell = (self.view.frame.width/2) - 20
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: sizeCell, height: sizeCell + 50)
        
        let cFrame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:self.view.frame.height)
        collectionView = UICollectionView(frame: cFrame, collectionViewLayout: layout)
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
    
    func select(index: Int) {
        popularMoviesPresenter?.select(movie: movies[index])
    }
    
    func showMovieDetails(to movie : MovieViewModel){
        guard let vc =  ViewControllerFactory.movieDetailsVC() as? MovieDetailsVC else { return }
        vc.movie = movie
        navigationController?.pushViewController(vc, animated: true)
    }
}
