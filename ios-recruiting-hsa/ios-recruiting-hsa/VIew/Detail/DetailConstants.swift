//
//  DetailConstants.swift
//  ios-recruiting-hsa
//
//  Created on 11-08-19.
//

import UIKit

enum DetailConstants {
    enum Cells {
        static let rowCount = 5
        
        enum Indexes {
            static let image = 0
            static let title = 1
            static let year = 2
            static let genere = 3
            static let overview = 4
        }
        
        static func separatorFrame(width: CGFloat) -> CGRect {
            return CGRect(x: 10, y: 0, width: width - 20, height: 1)
        }
    }
}
