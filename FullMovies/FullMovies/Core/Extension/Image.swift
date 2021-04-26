import UIKit

struct Image {
    static let empty = UIImage()
    
    enum Icon {
        static let list = icon(named: "icon-movies")
        static let favs = icon(named: "icon-favs")
    }
    
    static func icon(named: String) -> UIImage {
        if let image = UIImage(named: named) {
            return image
        }
        return Image.empty
    }
}
