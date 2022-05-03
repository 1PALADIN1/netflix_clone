//
//  MovieApiManager.swift
//  Netflix Clone
//
//  Created by Ruslan Malinovsky on 01.05.2022.
//

import Foundation

protocol MovieApiManagerDelegate {
    func didFetchTrendingMovies(titles: [TitleData])
    func didFetchTrendingTv(titles: [TitleData])
    func didFetchUpcomingMovies(titles: [TitleData])
    func didFetchPopularMovies(titles: [TitleData])
    func didFetchTopRatedMovies(titles: [TitleData])
    func didFetchDiscoverMovies(titles: [TitleData])
    
    func didFailWithError(error: Error)
}

struct MovieApiManager {
    
    var delegate: MovieApiManagerDelegate?
    
    private var baseURL: String {
        return AppConfig.shared.baseUrl
    }
    
    private var apiKey: String {
        return AppConfig.shared.apiKey
    }
    
    func fetchTrendingMovies() {
        let urlString = "\(baseURL)/3/trending/movie/day?api_key=\(apiKey)"
        fetchMovies(urlString: urlString) { results in
            delegate?.didFetchTrendingMovies(titles: results)
        }
    }
    
    func fetchTrendingTv() {
        let urlString = "\(baseURL)/3/trending/tv/day?api_key=\(apiKey)"
        fetchMovies(urlString: urlString) { results in
            delegate?.didFetchTrendingTv(titles: results)
        }
    }
    
    func fetchUpcomingMovies() {
        let urlString = "\(baseURL)/3/movie/upcoming?api_key=\(apiKey)&language=en-US&page=1"
        fetchMovies(urlString: urlString) { results in
            delegate?.didFetchUpcomingMovies(titles: results)
        }
    }
    
    func fetchPopularMovies() {
        let urlString = "\(baseURL)/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
        fetchMovies(urlString: urlString) { results in
            delegate?.didFetchPopularMovies(titles: results)
        }
    }
    
    func fetchTopRatedMovies() {
        let urlString = "\(baseURL)/3/movie/top_rated?api_key=\(apiKey)&language=en-US&page=1"
        fetchMovies(urlString: urlString) { results in
            delegate?.didFetchTopRatedMovies(titles: results)
        }
    }
    
    func fetchDiscoverMovies() {
        let urlString = "\(baseURL)/3/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
        fetchMovies(urlString: urlString) { results in
            delegate?.didFetchDiscoverMovies(titles: results)
        }
    }
    
    private func fetchMovies(urlString: String, successHandler: @escaping ([TitleData]) -> Void) {
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
                let response = try decoder.decode(MovieApiResponse.self, from: data)
                successHandler(response.results)
            } catch {
                delegate?.didFailWithError(error: error)
            }
        }
        
        task.resume()
    }
}

//MARK: - Default MovieApiManagerDelegate implementation

extension MovieApiManagerDelegate {
    func didFetchTrendingMovies(titles: [TitleData]) {
    }
    
    func didFetchTrendingTv(titles: [TitleData]) {
    }
    
    func didFetchUpcomingMovies(titles: [TitleData]) {
    }
    
    func didFetchPopularMovies(titles: [TitleData]) {
    }
    
    func didFetchTopRatedMovies(titles: [TitleData]) {
    }
    
    func didFetchDiscoverMovies(titles: [TitleData]){
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
