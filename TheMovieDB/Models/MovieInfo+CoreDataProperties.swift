//
//  MovieInfo+CoreDataProperties.swift
//  TheMovieDB
//
//  Created by Nikhlesh bagdiya on 03/07/22.
//
//

import Foundation
import CoreData

//NOTE: We can manage to create single class for NSManagedObject and api JSON Model as Codable, means same class satisfy NSManagedObject protocol and Codable protocol
//  By write convience init and decodaable and encodable functions in a class

extension MovieInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieInfo> {
        return NSFetchRequest<MovieInfo>(entityName: "MovieInfo")
    }

    @NSManaged public var poster_path: String?
    @NSManaged public var release_date: String?
    @NSManaged public var vote_average: Float
    @NSManaged public var popularity: Float
    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var comment: String?
    @NSManaged public var isPopular: Bool

}

extension MovieInfo : Identifiable {

}
