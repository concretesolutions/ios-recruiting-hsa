import SDWebImage
import UIKit

class MovieDetailImageCell: UITableViewCell {
    @IBOutlet var imageViewMovie: UIImageView!
    static let defaultHeight: CGFloat = 120

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(imgPath: String?, configurations: ConfigurationsProtocol) {
        let placeholderImage = UIImage() // Replace by another placeholder
        guard let imgEndpoint = configurations.string(for: .movieDbImgEndpoint), let imgPath = imgPath, let url = URL(string: imgEndpoint + imgPath) else {
            imageViewMovie.image = placeholderImage
            return
        }
        imageViewMovie.sd_setImage(with: url, placeholderImage: placeholderImage)
    }
}
