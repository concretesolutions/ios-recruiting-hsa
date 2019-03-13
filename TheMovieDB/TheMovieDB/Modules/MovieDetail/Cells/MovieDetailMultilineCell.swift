import UIKit

class MovieDetailMultilineCell: UITableViewCell {
    @IBOutlet var multilineLabel: UILabel!

    static let defaultHeight: CGFloat = 60

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(text: String?) {
        multilineLabel.text = text
    }
}
