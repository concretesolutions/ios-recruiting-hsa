//
//  SafeArray.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/7/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
