import UIKit

class SavedMovieCell: UITableViewCell {
    @IBOutlet var imageViewCover: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelDate: UILabel!
    @IBOutlet var labelAverage: UILabel!
    private let placeholderImage = UIImage(named: "coverPlaceholder")

    static let defaultHeight: CGFloat = 140

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        labelTitle.text = ""
        imageViewCover.image = placeholderImage
        imageViewCover.contentMode = .center
    }

    func setupCell(title: String?,
                   date: String?,
                   average: Double,
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
        labelDate.text = date
        labelAverage.text = String(format: "%.1f", average)
    }
}
