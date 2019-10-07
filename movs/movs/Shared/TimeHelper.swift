//
//  TimeHelper.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

struct TimeHelper{
    
    static func getYearFromDate(dateString: String)->String?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        
        guard let date = dateFormatter.date(from: dateString) else{
            return nil
        }
        
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: date)
        
        return year
    }
    
}
