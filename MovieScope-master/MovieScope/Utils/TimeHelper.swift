//
//  TimeHelper.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/7/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

struct TimeHelper{
    
    static func getFormattedTime(fromMinutes: Int)->String?{
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .short
        let timeIntervalInSeconds = fromMinutes * 60
        let formattedString = formatter.string(from: TimeInterval(timeIntervalInSeconds))
        return formattedString
    }
    
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
