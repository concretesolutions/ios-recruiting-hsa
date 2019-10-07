//
//  CoreDataError.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

enum CoreDataError: Error{
    case noExistingRecords
}

extension CoreDataError: LocalizedError{
    
    public var errorDescription: String? {
        switch self {
        case .noExistingRecords:
            return NSLocalizedString("No existing records for data query.", comment: "")
        }
    }
    
}
