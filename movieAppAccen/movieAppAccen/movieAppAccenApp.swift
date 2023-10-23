//
//  movieAppAccenApp.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 19-10-23.
//

import SwiftUI

@main
struct movieAppAccenApp: App {
    
    init() {
        setupAPIKey()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func setupAPIKey() {
        if KeychainManager.shared.get(key: KeychainKeys.apiKey) == nil {
            let apiKeyValue = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MjAxY2M5YzExYThjYjdiMDlkNTA3MzExMTZlZjdkMSIsInN1YiI6IjY1MmVmMjVhMzU4ZGE3NWI2MWY5OTNkNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.dIxmT9seCTpQ3i9pgNNtZfouZEYRtmk34nbXFnizCaQ"
            KeychainManager.shared.save(key: KeychainKeys.apiKey, value: apiKeyValue)
        }
    }
}
