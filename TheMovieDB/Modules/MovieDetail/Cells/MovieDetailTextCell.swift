import UIKit

class MovieDetailTextCell: UITableViewCell {
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelDetail: UILabel!

    static let defaultHeight: CGFloat = 80.0

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(title: String?, detail: String?) {
        labelTitle.text = title
        labelDetail.text = detail
    }
}
