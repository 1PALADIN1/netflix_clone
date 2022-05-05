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

extension TitleData {
    func copyTo(entity: TitleEntity) {
        entity.id = Int64(id)
        entity.media_type = media_type
        entity.original_name = original_name
        entity.original_title = original_title
        entity.poster_path = poster_path
        entity.overview = overview
        entity.vote_count = Int64(vote_count)
        entity.release_date = release_date
        entity.vote_average = vote_average
    }
    
    static func createFromEntity(entity: TitleEntity) -> TitleData {
        let title = TitleData(id: Int(entity.id), media_type: entity.media_type,
                              original_name: entity.original_name, original_title: entity.original_title,
                              poster_path: entity.poster_path, overview: entity.overview,
                              vote_count: Int(entity.vote_count), release_date: entity.release_date,
                              vote_average: entity.vote_average)
        
        return title
    }
}
