//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Accenture on 28-06-22.
//

import Foundation


extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
