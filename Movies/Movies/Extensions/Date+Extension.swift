//
//  Date+Extension.swift
//  Movies
//
//  Created by Daniel Nunez on 05-03-21.
//

import Foundation

extension Date {

    func toString(format: String = "dd/MM/yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }


}
