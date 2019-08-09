//
//  FormatHelper.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

import Foundation

class FormatHelper {
    class func date(from string: String?) -> Date? {
        guard let string = string else {
            return nil
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.date(from: string)
    }
    
    class func stringDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: date)
    }
    
    class func string(from number: Int?) -> String {
        guard let number = number else {
            return ""
        }
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
    
    class func string(from number: Double?) -> String {
        guard let number = number else {
            return ""
        }
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}