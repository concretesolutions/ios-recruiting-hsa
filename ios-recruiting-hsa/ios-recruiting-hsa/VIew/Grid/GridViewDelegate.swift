//
//  GridViewDelegate.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

import UIKit

class GridViewDelegate: NSObject {
    private var view: GridViewController?
    
    func attach(view: GridViewController) {
        self.view = view
    }
}

extension GridViewDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieId = view?.movies[indexPath.row].id,
            let viewController = ViewFactory.viewController(viewType: .detail) as? DetailViewController {
            viewController.movieId = movieId
            viewController.hidesBottomBarWhenPushed = true
            view?.pushViewController(viewController: viewController)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let view = view {
            if view.collectionView.contentOffset.y >= (view.collectionView.contentSize.height - view.collectionView.frame.size.height) {
                view.endOfCollectionReached()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let view  = view {
            let paddingSpace = view.sectionInsets.left * (view.itemsPerRow + 1)
            let availableWidth = collectionView.bounds.width - paddingSpace
            let widthPerItem = availableWidth / view.itemsPerRow
            
            return CGSize(width: widthPerItem, height: widthPerItem + (widthPerItem * Constants.Images.gridMultiplier))
        }
        
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return view?.sectionInsets ?? UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return view?.sectionInsets.left ?? 0
    }
}
