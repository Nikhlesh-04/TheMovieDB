//
//  API.swift
//  TheMovieDB
//
//  Created by Nikhlesh bagdiya on 02/07/22.
//

import Foundation

enum API:String {
    
    case popular                 = "movie/popular"
    case toprated                = "movie/top_rated"
    case videos                  = "movie/"
}

extension API : APIRequirement {
    
    static var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var apiHeader: [String : String] {
        return Constants.kHeaders
    }
    
    var defaultParams: [String : String] {
        return ["api_key":TheMovieDB.apiKey]
    }
    
    var apiPath: String {
        return "\(API.baseURL)"
    }
    
    var methodPath: String {
        return self.rawValue
    }
}
