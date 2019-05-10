//
//  MTAReachability.swift
//  MovieApp
//
//  Created by Andres Ortiz on 4/17/19.
//  Copyright © 2019 Andres. All rights reserved.
//


import Foundation
import Reachability

class MTAReachability {

    static let shared = MTAReachability()

    let reachability = Reachability()
    var reachable : Bool?

    init() {
        
        self.reachable = false
        
        reachability!.whenReachable = { reachability in
            if reachability.connection == .wifi {
                self.reachable = true
                print("Reachable via WiFi")
            } else {
                self.reachable = true
                print("Reachable via Cellular")
            }
        }
        reachability!.whenUnreachable = { _ in
            self.reachable = false
            print("Not reachable")
        }
        
        do {
            try reachability!.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    
    func isConnected() -> Bool
    {
        var isNetAvailable = false;
        
        let reach = Reachability(hostname: "www.google.com")
        let netStatus = reach!.connection
        if (netStatus != .none)
        {
            isNetAvailable = true;
        }
        else
        {
            isNetAvailable = false;
        }
        return  isNetAvailable;
        //return reachable!
    }

}
