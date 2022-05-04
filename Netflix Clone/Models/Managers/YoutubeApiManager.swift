//
//  YoutubeApiManager.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 04.05.2022.
//

import Foundation

protocol YoutubeApiManagerDelegate {
    func didSearchOnYoutube(video: YoutubeData)
    
    func didFailWithError(error: Error)
}

struct YoutubeApiManager {
    
    var delegate: YoutubeApiManagerDelegate?
    
    private var youtubeApiBaseUrl: String {
        return AppConfig.shared.youtubeApiBaseUrl
    }
    
    private var youtubeApiKey: String {
        return AppConfig.shared.youtubeApiKey
    }
    
    func searchMovieOnYoutube(with query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        let urlString = "\(youtubeApiBaseUrl)/search?q=\(query)&key=\(youtubeApiKey)"
        guard let url = URL(string: urlString) else {
            delegate?.didFailWithError(error: ApiError.errorUrlString(urlString))
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                delegate?.didFailWithError(error: error)
                return
            }
            
            guard let data = data else {
                delegate?.didFailWithError(error: ApiError.emptyResponseData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(YoutubeApiResponse.self, from: data)
                guard let firstVideo = response.items.first else {
                    delegate?.didFailWithError(error: ApiError.notFoundYoutubeVideo)
                    return
                }
                
                delegate?.didSearchOnYoutube(video: firstVideo)
            } catch {
                delegate?.didFailWithError(error: error)
            }
        }
        
        task.resume()
    }
}

//MARK: - Default YoutubeApiManagerDelegate implementation

extension YoutubeApiManagerDelegate {
    func didSearchOnYoutube(video: YoutubeData) {
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
