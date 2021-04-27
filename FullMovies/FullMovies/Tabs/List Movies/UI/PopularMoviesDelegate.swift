import UIKit

class PopularMoviesDelegate: NSObject {
    var popularMoviesVC : PopularMoviesView?
}

extension PopularMoviesDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
    }
}
