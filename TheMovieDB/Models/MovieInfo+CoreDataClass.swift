//
//  MovieInfo+CoreDataClass.swift
//  TheMovieDB
//
//  Created by Nikhlesh bagdiya on 03/07/22.
//
//

import Foundation
import CoreData

//NOTE: We can manage to create single class for NSManagedObject and api JSON Model as Codable, means same class satisfy NSManagedObject protocol and Codable protocol
//  By write convience init and decodaable and encodable functions in a class

@objc(MovieInfo)
public class MovieInfo: NSManagedObject {

}
