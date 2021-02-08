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
extension UIImageView {
    func loadFromUrl(url: String, activityIndicator: UIActivityIndicatorView?, errorImage: UIImage?) {
        let fileManager = FileManager.default
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let pathSplit = url.components(separatedBy: "/")
        let getImagePath = (paths as NSString).appendingPathComponent("\(pathSplit[pathSplit.count-1])")
        if (fileManager.fileExists(atPath: getImagePath)){
            func display_image2(){
                self.image = UIImage(contentsOfFile: getImagePath)
                activityIndicator?.isHidden = true
            }
            DispatchQueue.main.async(execute: display_image2)
        }else{
            activityIndicator?.isHidden = false
            self.image = errorImage
            
            let encodedString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)
            let imgURL: URL = URL(string: encodedString!)!
            let request: URLRequest = URLRequest(url: imgURL)
            
            let urlconfig = URLSessionConfiguration.default
            urlconfig.timeoutIntervalForRequest = 10
            urlconfig.timeoutIntervalForResource = 10
            urlconfig.waitsForConnectivity = true
            
            let session = URLSession(configuration: urlconfig)
            let task = session.dataTask(with: request, completionHandler: {
                (data, response, error) -> Void in
                OperationQueue.main.addOperation {
                    activityIndicator?.isHidden = true
                }
                if (error == nil && data != nil && data!.count > 0){
                    func display_image(){
                        if let image = UIImage(data: data!){
                            self.image = image
                            if let data = image.jpegData(compressionQuality: 0.8) {
                                try? data.write(to: URL(fileURLWithPath: getImagePath), options: [.atomic])
                            }
                        }
                    }
                    DispatchQueue.main.async(execute: display_image)
                }
            })
            
            task.resume()
        }
    }
}
