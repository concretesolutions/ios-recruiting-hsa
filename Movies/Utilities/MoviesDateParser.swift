//
//  MoviesDateParser.swift
//  Movies
//
//  Created by Pedro on 27-07-24.
//

import Foundation

struct MoviesDateParser {
    static func parseYearFrom(
        stringDate: String,
        dateFormat: String = "yyyy-MM-dd"
    ) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        if let date = dateFormatter.date(from: stringDate) {
            let components = Calendar.current.dateComponents(
                [.year],
                from: date
            )
            return components.year.map { "\($0)" }
        }
        return nil
    }
}
