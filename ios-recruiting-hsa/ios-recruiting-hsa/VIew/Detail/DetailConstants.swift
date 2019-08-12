//
//  DetailConstants.swift
//  ios-recruiting-hsa
//
//  Created on 11-08-19.
//

import UIKit

enum DetailConstants {
    enum Messages {
        static let emptyGenres = "We don't have any genre for this movie..."
        static let emptyOverview = "We don't have an overview..."
    }
    enum Cells {
        static let rowCount = 5
        
        enum Indexes {
            static let image = 0
            static let title = 1
            static let year = 2
            static let genere = 3
            static let overview = 4
        }
        
        enum Label {
            static let width: CGFloat = 30
        }
        
        static func separatorFrame(width: CGFloat) -> CGRect {
            return CGRect(x: 10, y: 0, width: width - 20, height: 1)
        }
    }
}
