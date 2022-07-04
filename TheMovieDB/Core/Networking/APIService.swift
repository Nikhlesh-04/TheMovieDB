//
//  APIService.swift
//  TheMovieDB
//
//  Created by Nikhlesh bagdiya on 03/07/22.
//

import Foundation

class APIService {
    
    static let shared:APIService = APIService()

    private init() {}
        
    func getPopularMovies(page: Int,completion: @escaping (Movie?, Error?) -> ()) {
        API.popular.request(with: ["page":page], objectType: Movie.self) { object, error in
            if let movies = object {
                DispatchQueue.main.async {
                    completion(movies, nil)
                }
            } else {
                let movies = CoreDataHelper.shared.fetchPoplulerMovies()
                completion(movies, nil)
            }
        }
    }
    
    func getVideos(movieId:Int, completion: @escaping (Videos?, Error?) -> ()) {
        API.videos.request(urlParameter: "\(movieId)" + "/videos", objectType: Videos.self) { object, error in
            if let videos = object {
                DispatchQueue.main.async {
                    completion(videos, nil)
                }
            } else {
                completion(nil, error)
            }
        }
    }
    
    func getTopRatedMovies(page: Int,completion: @escaping (Movie?, Error?) -> ()) {
        API.toprated.request(with: ["page":page], objectType: Movie.self) { object, error in
            if let movies = object {
                DispatchQueue.main.async {
                    completion(movies, nil)
                }
            } else {
                let movies = CoreDataHelper.shared.fetchTopRatedMovies()
                completion(movies, nil)
            }
        }
    }
}
