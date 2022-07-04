//
//  Movie.swift
//  TheMovieDB
//
//  Created by Nikhlesh bagdiya on 03/07/22.
//

import Foundation

struct Movie: Codable {
    var page: Int                  = 0
    var results: [MovieInfoModel]  = []
    var total_pages: Int            = 0
    var total_results: Int          = 0
}
