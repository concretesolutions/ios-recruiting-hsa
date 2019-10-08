//
//  CurrencyHelper.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/7/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

struct CurrencyHelper{
    
    static func getCurrencyValue(forInt: Int)->String?{
        
        let doubleValue = Double.init(forInt)
        let number = NSDecimalNumber.init(value: doubleValue)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.locale = Locale.init(identifier: "en_US")
        let result = numberFormatter.string(from: number)
        return result
    }
    
}
