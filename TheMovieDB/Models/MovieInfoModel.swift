//
//  MovieInfoModel.swift
//  TheMovieDB
//
//  Created by Nikhlesh bagdiya on 03/07/22.
//

import Foundation

//NOTE: We can manage to create single class for NSManagedObject and api JSON Model as Codable, means same class satisfy NSManagedObject protocol and Codable protocol
//  By write convience init and decodaable and encodable functions in a class

struct MovieInfoModel: Codable {
    var poster_path: String?    = nil
    var release_date: String    = ""
    var vote_average: Float     = 0.0
    var popularity: Float       = 0.0
    var id: Int                 = 0
    var title: String           = ""
    var overview: String        = ""
    
    var comment:String  {
        return CoreDataHelper.shared.fetchMovieMCO(movieId: id)?.comment ?? ""
    }
    
    var displayDate:String {
        return release_date.convertToShowFormatDate(dateFormatForInput: "yyyy-MM-dd", dateFormatForOutput: "MMM dd, yyyy")
    }
}
