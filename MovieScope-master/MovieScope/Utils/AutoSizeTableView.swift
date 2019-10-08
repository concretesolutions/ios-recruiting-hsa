//
//  AutoSizeTableView.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/4/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

//Clase de tableview que escala su height en base al tamaño de su contenido
class AutoSizeTableView: UITableView{
    
    
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
        
    }
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
}
