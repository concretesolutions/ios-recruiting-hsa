//
//  Date.swift
//  Movs
//
//  Created by Miguel Duran on 1/8/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import Foundation

extension Date {
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy"
        return  dateFormatter.string(from: self)
    }
}
