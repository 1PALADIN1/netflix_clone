//
//  YoutubeData.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 04.05.2022.
//

struct YoutubeApiResponse: Decodable {
    let items: [YoutubeData]
}

struct YoutubeData: Decodable {
    let id: YoutubeDataId
}

struct YoutubeDataId: Decodable {
    let kind: String
    let videoId: String
}
