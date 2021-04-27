import UIKit

class PopularMoviesDelegate: NSObject {
    var popularMoviesVC : PopularMoviesView?
}

extension PopularMoviesDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        popularMoviesVC?.select(index : indexPath.row)
    }
}
