//
//  ActiveBuildConfigurationInfo.swift
//  Movies
//
//  Created by Pedro on 28-07-24.
//

import Foundation

struct ActiveBuildInfo {
    static var name: String {
        #if UI_TEST
        "UI_TEST"
        #elseif SNAPSHOT_TEST
        "SNAPSHOT_TEST"
        #else
        "DEBUG"
        #endif
    }
}
