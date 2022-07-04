//
//  Videos.swift
//  TheMovieDB
//
//  Created by Nikhlesh bagdiya on 04/07/22.
//

import Foundation

struct Videos: Codable {
    var id: Int                  = 0
    var results: [Video]        = []
}

struct Video: Codable {
    var name:String             = ""
    var key:String              = ""
    var site:String             = ""
    var size:Int                = 0
    var type:String             = ""
    var official:Bool           = false
    var published_at:String     = ""
    var id:String               = ""
}
