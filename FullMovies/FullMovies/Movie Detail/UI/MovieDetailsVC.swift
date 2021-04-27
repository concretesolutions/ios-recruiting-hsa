import UIKit

class MovieDetailsVC: BaseViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    var movie : MovieViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.ViewTitle.movie
        setup()
    }

    private func setup(){
        movieTitle.text = movie?.title
        movieYear.text = movie?.year
        movieOverview.text = movie?.overview
        movieOverview.numberOfLines = 0
        //TO DO: LOAD URL IMAGE
        movieImage.image = UIImage(named: Constants.Generic.placeholder)
    }
}
