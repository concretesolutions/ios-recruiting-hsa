//
//  ContainerPresenter.swift
//  TestProject
//
//  Created by Felipe S Vergara on 21-10-18.
//  Copyright © 2018 MyOwnCompany. All rights reserved.
//

import Foundation

protocol ContainerEventResponse{
    //Thinking in future to use it ... 
}


class ContainerPresenter{
    
    var presenterResponse: ContainerEventResponse?
    
    init(delegate: ContainerEventResponse) {
        self.presenterResponse = delegate
    }
    
}
