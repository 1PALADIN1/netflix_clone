//
//  AppConfig.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 02.05.2022.
//

import Foundation

struct AppConfig {
    static let shared = AppConfig()
    
    private var appData: AppConfigData?
    
    var baseUrl: String {
        return appData?.baseUrl ?? ""
    }
    
    var apiKey: String {
        return appData?.apiKey ?? ""
    }
    
    var imageBaseUrl: String {
        return appData?.imageBaseUrl ?? ""
    }
    
    private init() {
        appData = loadConfig()
    }
    
    private func loadConfig() -> AppConfigData? {
        guard let url = Bundle.main.url(forResource: "App", withExtension: "plist") else {
            fatalError("Error loading App.plist...")
        }
        
        do {
            let decoder = PropertyListDecoder()
            let data = try Data(contentsOf: url)
            let decodedData = try decoder.decode(AppConfigData.self, from: data)
            return decodedData
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
