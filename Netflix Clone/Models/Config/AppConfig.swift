//
//  AppConfig.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 02.05.2022.
//

import Foundation

struct AppConfig {
    static let shared = AppConfig()
    
    private var baseUrl: String?
    private var apiKey: String?
    
    var url: String {
        return baseUrl ?? ""
    }
    
    var key: String {
        return apiKey ?? ""
    }
    
    private init() {
        guard let configData = loadConfig() else { return }
        baseUrl = configData.baseUrl
        apiKey = configData.apiKey
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
            print(error)
            fatalError(error.localizedDescription)
        }
    }
}
