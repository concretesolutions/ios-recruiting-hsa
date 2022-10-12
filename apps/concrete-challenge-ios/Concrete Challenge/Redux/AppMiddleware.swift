//
//  AppMiddleware.swift
//  Yuno Demo
//
//  Created by Jonathan Pacheco on 22/09/22.
//

import Foundation
import Redux

let appMiddleware = MiddlewareGroup<AppState>([
    LoggerMiddleware(),
    GetPopularMoviesMiddleware(),
    GetGenresMiddleware(),
    LocalStorageMiddleware()
])
