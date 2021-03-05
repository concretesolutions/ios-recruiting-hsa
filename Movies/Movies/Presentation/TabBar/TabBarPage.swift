//
//  TabBarPage.swift
//  Movies
//
//  Created by Daniel Nunez on 03-03-21.
//

import UIKit

enum TabBarPage {
    case movies
    case favorites

    init?(index: Int) {
        switch index {
        case 0:
            self = .movies
        case 1:
            self = .favorites
        default:
            self = .movies
        }
    }

    func title() -> String {
        switch self {
        case .movies:
            return NSLocalizedString("Peliculas", comment: "")
        case .favorites:
            return NSLocalizedString("Favoritos", comment: "")
        }
    }

    func order() -> Int {
        switch self {
        case .movies:
            return 0
        case .favorites:
            return 1
        }
    }

    func icon() -> UIImage {
        switch self {
        case .movies:
            return #imageLiteral(resourceName: "list_icon.png")
        case .favorites:
            return #imageLiteral(resourceName: "favorite_empty_icon.png")
        }
    }
}
