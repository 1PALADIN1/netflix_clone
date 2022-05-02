//
//  MovieApiManager.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 01.05.2022.
//

import Foundation

protocol MovieApiManagerDelegate {
    func didFetchTrendingMovies(movies: [MovieData])
    
    func didFailWithError(error: Error)
}

struct MovieApiManager {
    
    var delegate: MovieApiManagerDelegate?
    
    private var baseURL: String {
        return AppConfig.shared.url
    }
    
    private var apiKey: String {
        return AppConfig.shared.key
    }
    
    func fetchTrendingMovies() {
        let urlString = "\(baseURL)/3/trending/all/day?api_key=\(apiKey)"
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
                let response = try decoder.decode(TrendingMoviesResponse.self, from: data)
                delegate?.didFetchTrendingMovies(movies: response.results)
            } catch {
                delegate?.didFailWithError(error: error)
            }
        }
        
        task.resume()
    }
}
