import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleMovie.numberOfLines = 2
        titleMovie.lineBreakMode = .byWordWrapping
        imageMovie.contentMode = .scaleAspectFill
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("MovieCollectionViewCell", owner: self, options: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupCellWith(movie: MovieViewModel){
        titleMovie.text = movie.title
        //TO DO: LOAD URL IMAGE
        imageMovie.image = UIImage(named: Constants.Generic.placeholder)
        
    }
}
