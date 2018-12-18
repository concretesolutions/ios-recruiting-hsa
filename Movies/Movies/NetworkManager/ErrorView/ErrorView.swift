//
//  ErrorView.swift
//  Movies
//
//  Created by Consultor on 12/17/18.
//  Copyright © 2018 Mavzapps. All rights reserved.
//

import UIKit

protocol ErrorViewDelegate {
    func buttonAction(_ errorView: ErrorView)
}

class ErrorView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var errorImageView: UIImageView!
    @IBOutlet weak var errorDescriptionLabel: UILabel!
    @IBOutlet weak var errorActionButton: UIButton!
    
    var delegate: ErrorViewDelegate? = nil
    
    convenience init(error: ErrorTypes){
        self.init(frame: UIScreen.main.bounds)
        loadErrorView(error)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    func loadErrorView(_ error: ErrorTypes){
        Bundle.main.loadNibNamed("ErrorView", owner: self, options: nil)
        self.addSubview(contentView)
        errorDescriptionLabel.text = NSLocalizedString(error.message, comment: "")
        errorActionButton.setTitle(NSLocalizedString(error.buttonTitle, comment: ""), for: .normal)
        errorImageView.image = error.image
        contentView.addConstraintsToCenter()
    }
    
    func hideErrorView(){
        self.removeFromSuperview()
    }
    
    @IBAction func errorButtonAction(_ sender: Any) {
        delegate?.buttonAction(self)
    }
}
enum ErrorTypes: Error{
    case networkError
    case savingError
    case removingError
    case emptyFavoritesError
    case emptyListError
    case genericError
    
    var message: String {
        switch self {
        case .networkError:         return "errors.network.general"
        case .savingError:          return "errors.favorites.save"
        case .removingError:        return "errors.favorites.remove"
        case .genericError:         return "errors.network.movies"
        case .emptyFavoritesError:  return "errors.favorites.empty"
        case .emptyListError:       return "errors.search.noresults"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .networkError:         return "errors.action.reload"
        case .savingError:          return "errors.action.tryagain"
        case .removingError:        return "errors.action.tryagain"
        case .genericError:         return "errors.action.tryagain"
        case .emptyFavoritesError:  return "errors.action.gohome"
        case .emptyListError:       return "errors.action.tryagain"
        }
    }
    
    var image: UIImage?{
        switch self {
        case .networkError:         return UIImage(named: "networkErrorImage")
        case .savingError:          return UIImage(named: "favoriteErrorImage")
        case .removingError:        return UIImage(named: "favoriteErrorImage")
        case .genericError:         return UIImage(named: "errorImage")
        case .emptyFavoritesError:  return UIImage(named: "favoriteErrorImage")
        case .emptyListError:       return UIImage(named: "searchErrorImage")
        }
    }
}
extension UIView {
    func addConstraintsToCenter(scale: CGFloat = 1){
        self.translatesAutoresizingMaskIntoConstraints = false;
        let centerX = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.width, multiplier: scale, constant: 0)
        let height = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.height, multiplier: scale, constant: 0)
        self.superview?.addConstraints([centerX, centerY, width, height])
    }
    
    public func layoutAttachAll(to parentView:UIView)
    {
        var constraints = [NSLayoutConstraint]()
        self.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: parentView, attribute: .left, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: parentView, attribute: .right, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: parentView, attribute: .top, multiplier: 1.0, constant: 0))
        constraints.append(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: parentView, attribute: .bottom, multiplier: 1.0, constant: 0))
        parentView.addConstraints(constraints)
    }
}
