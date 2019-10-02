//
//  HTTPClient.swift
//  Re-Counter
//
//  Created by Andrés Alexis Rivas Solorzano on 7/29/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

protocol HTTPClient{
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    func executeRequest(request: URLRequest, completion: @escaping (Result)->Void)
}
