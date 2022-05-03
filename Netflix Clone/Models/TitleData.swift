//
//  Movie.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 01.05.2022.
//

import Foundation

struct MovieApiResponse: Decodable {
    let results: [TitleData]
}

struct TitleData: Decodable {
    
    var titleName: String {
        return original_name ?? original_title ?? "Unknown"
    }
    
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
    
    func getPosterUrl(with imageBaseUrl: String) -> URL? {
        guard let pathUrl = poster_path else {
            print("Poster for title \(id) is not specified!")
            return nil
        }
        
        let urlString = "\(imageBaseUrl)\(pathUrl)"
        guard let url = URL(string: urlString) else {
            print("Error creating url from string \(urlString)!")
            return nil
        }
        
        return url
    }
}

