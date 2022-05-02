//
//  Movie.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 01.05.2022.
//

struct TrendingMoviesResponse: Codable {
    let results: [MovieData]
}

struct MovieData: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}

