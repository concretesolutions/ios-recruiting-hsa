//
//  DataBaseErrors.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/13/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

enum DBError: Error{
    case noExistingRecords
}

extension DBError: LocalizedError{
    
    public var errorDescription: String? {
        switch self {
        case .noExistingRecords:
            return NSLocalizedString("No existing records for data query.", comment: "COREDATAWHY")
        }
    }
    
}
