import UIKit

class PopularMoviesDataSource: NSObject {
    var popularMoviesVC : PopularMoviesView?
}

extension PopularMoviesDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMoviesVC?.movies.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        if let movie = popularMoviesVC?.movies[indexPath.row] {
            cell.setupCellWith(movie: movie)
        }
        return cell
    }
    
}
