import UIKit

class MovieListCell: UICollectionViewCell {
    @IBOutlet var imageViewCover: UIImageView!
    @IBOutlet var viewTitle: UIView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var imageViewSaved: UIImageView!
    private let placeholderImage = UIImage(named: "coverPlaceholder")

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageViewSaved.image = UIImage(named: "favoriteIcon.empty")
        labelTitle.text = ""
        imageViewCover.image = placeholderImage
        imageViewCover.contentMode = .center
    }

    func setupCell(title: String?,
                   isSaved: Bool,
                   imgPath: String?,
                   configurations: ConfigurationsProtocol) {
        if let imgEndpoint = configurations.string(for: .movieDbImgEndpoint),
            let imgPath = imgPath,
            let url = URL(string: imgEndpoint + imgPath) {
            imageViewCover.sd_setImage(with: url, placeholderImage: placeholderImage) { image, _, _, _ in
                if let image = image {
                    OperationQueue.main.addOperation {
                        self.imageViewCover.image = image
                        self.imageViewCover.contentMode = .scaleAspectFill
                    }
                }
            }
        } else {
            imageViewCover.image = placeholderImage
            imageViewCover.contentMode = .center
        }

        labelTitle.text = title
        let imageName = isSaved ? "favoriteIcon.full" : "favoriteIcon.empty"
        imageViewSaved.image = UIImage(named: imageName)
    }
}
