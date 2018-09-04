//
//  FilterTableViewCell.swift
//  moviewsApp
//
//  Created by carlos jaramillo on 9/1/18.
//  Copyright © 2018 carlos jaramillo. All rights reserved.
//

import UIKit


protocol filterCellDelegate : class {
    func didTapArrow(index : Int)
}
class FilterTableViewCell: UITableViewCell {
    
    let leftLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    let rightImage : UIImageView = {
        let object = UIImageView()
        object.contentMode = .scaleAspectFill
        object.clipsToBounds = true
        object.translatesAutoresizingMaskIntoConstraints = false
        return object
    }()
    let rightLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "principalColor")
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    let line : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    var imageWidthConstraint : NSLayoutConstraint?
    var imageHeightConstraint : NSLayoutConstraint?
    var delegate : filterCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        if self.imageWidthConstraint == nil{
            
            let widthValue : CGFloat = 0
            let heightValue : CGFloat = 0
            
            self.addSubview(self.leftLabel)
            self.leftLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0).isActive = true
            self.leftLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            
            
            self.addSubview(self.rightImage)
            self.rightImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0).isActive = true
            self.rightImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            self.imageWidthConstraint = self.rightImage.widthAnchor.constraint(equalToConstant: widthValue)
            self.imageWidthConstraint?.isActive = true
            self.imageHeightConstraint = self.rightImage.heightAnchor.constraint(equalToConstant: heightValue)
            self.imageHeightConstraint?.isActive = true
            
            
            self.addSubview(self.rightLabel)
            self.rightLabel.trailingAnchor.constraint(equalTo: self.rightImage.leadingAnchor, constant: -10).isActive = true
            self.rightLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            
            self.addSubview(self.line)
            self.line.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5).isActive = true
            self.line.leadingAnchor.constraint(equalTo: self.leftLabel.leadingAnchor, constant: 0).isActive = true
            self.line.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
            self.line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        }
    }
    
    func settupCell(typeCell : String){
        if typeCell == "Principal"{
            self.imageWidthConstraint?.constant = 12
            self.imageHeightConstraint?.constant = 20
            self.rightImage.image = #imageLiteral(resourceName: "arrow-right")
            self.rightImage.gestureRecognizers = []
            self.rightImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapImage)))
            self.rightImage.isUserInteractionEnabled = true
        }
        else{
            self.rightImage.image = #imageLiteral(resourceName: "check-icon")
            self.imageWidthConstraint?.constant = 20
            self.imageHeightConstraint?.constant = 15
        }
    }
    
    
    /// metodo que ejecuta el delegado que le indica a la vista que se dio tap a la flecha para abrir las opciones del filtro
    @objc func tapImage(){
        guard let tableView = self.superview as? UITableView else {
            return
        }
        guard let indexPath = tableView.indexPath(for: self)  else {
            return
        }
        self.delegate?.didTapArrow(index: indexPath.row)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
