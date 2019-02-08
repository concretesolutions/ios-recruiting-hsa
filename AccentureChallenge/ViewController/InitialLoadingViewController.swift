//
//  InitialLoadingViewController.swift
//  AccentureChallenge
//
//  Created by Jaime on 2/4/19.
//  Copyright © 2019 Jaime. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NotificationBannerSwift

class InitialLoadingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        loadInitialData()
        
    }

    func loadInitialData() {

        _ = APIManager.sharedInstance.getMovieTypes(){ isSuccess, jsonResponse in
            
            if isSuccess {
                
                var movieTypes = [Genre]()
                
                for element in jsonResponse!["genres"].array! {
                    
                    let movieType = Genre()
                    movieType.id = element["id"].intValue
                    movieType.name = element["name"].stringValue
                    movieTypes.append(movieType)
                    
                }
                
                try! self.realm.write {
                    
                    self.realm.add(movieTypes, update: true)
                    
                }
                
                self.performSegue(withIdentifier: "homeSegue", sender: nil)
                
            } else {
                
                let banner = StatusBarNotificationBanner(title: "Error al cargar los datos. Intentando nuevamente...", style: .danger)
                banner.show()
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
                    
                    self.loadInitialData()
                    
                }
            }
        }
    }
}
