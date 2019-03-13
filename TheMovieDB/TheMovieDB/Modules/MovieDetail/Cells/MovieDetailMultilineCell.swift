import UIKit

class MovieDetailMultilineCell: UITableViewCell {
    @IBOutlet var multilineLabel: UILabel!
    @IBOutlet var labelTitle: UILabel!

    static let defaultHeight: CGFloat = 60

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(title: String?, text: String?) {
        labelTitle.text = title
        multilineLabel.text = text
    }
}
