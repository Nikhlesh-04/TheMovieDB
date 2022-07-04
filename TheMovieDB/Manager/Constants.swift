//
//  Constants.swift
//  TheMovieDB
//
//  Created by Nikhlesh bagdiya on 02/07/22.
//

import Foundation
import SwiftUI
import SimpleToast

public struct Constants {
    
    static let kUserDefaults        = UserDefaults.standard

    static let kScreenWidth         = UIScreen.main.bounds.width
    static let kScreenHeight        = UIScreen.main.bounds.height
    
    static let kHeaders = ["Content-Type": "application/json"]
    
    static let typeSizes: [DynamicTypeSize] = [
        .xSmall,
        .large,
        .xxxLarge
    ]
    
    static func setupAppearance(colorScheme:ColorScheme) {
        ColourStyle.shared.colorScheme = colorScheme
    }
    
    static let appName = "TheMovieDB"
    
    static let toastOptions = SimpleToastOptions(
        hideAfter: 5
    )
}

public struct TheMovieDB {
    static let apiKey                   = "8d9dc82bf6dd2091810e30c9da7b35bd"
    static var fetch:FetchData          = .api
    static let imageBaseURL             = "https://image.tmdb.org/t/p/original"
}

public struct UserDefaultsConstants {
    static let userState = "UserState"
}

// MARK: - Web Service Constans Objects.
public struct ApiConstants {
    static let apiTimeoutTime =  60 //Seconds.
}

// MARK: - Error Messages Objects.
public struct ConstantsMessages {
    
    static let welcomeText                  = "Welcome to The Movie DB"
    static let navigationPopularTitle       = "Trending"
    static let navigationTopRatedTitle      = "Favorite"
    static let noFavourites                 = "Sorry you don't have any favourites"
    static let popularTab                   = "Popular"
    static let topRatedTab                  = "Top Rated"
    static let noMoreScroll                 = "No more data is available"
    static let comment                      = "Comment save successfully"
}

public struct Identifiers {
    
    static let popularTable             = "popular_table_view"
    static let topratedTable            = "toprated_table_view"
    static let cellImageView            = "cell_imageView"
}

public struct ConstantImage {
    
    static let personCircle     = "person.circle.fill"
    static let popular          = "tv.fill"
    static let topRated         = "star.circle.fill"
    static let moviePlaceholder = "moviePlaceholder"
    static let watchTralior     = "film.fill"
    
}

public enum CustomError: Error {
    case sometingWentWrong
}

public enum FetchData {
    case api
    case local
}
