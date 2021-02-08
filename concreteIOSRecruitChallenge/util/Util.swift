//
//  Util.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 08-02-21.
//

import UIKit

class Util: NSObject {
    static func stringJsonToDictionary(_ json:String) -> [String:AnyObject]{
        var dict:[String: AnyObject]
        if (json.data(using: String.Encoding.utf8) != nil) {
            let data = json.data(using: String.Encoding.utf8, allowLossyConversion: false)!
            do {
                dict = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                return dict
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
            return [:]
        }
        return [:]
    }
}
