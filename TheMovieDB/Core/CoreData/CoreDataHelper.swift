//
//  CoreDataHelper.swift
//  TheMovieDB
//
//  Created by Nikhlesh bagdiya on 03/07/22.
//

import Foundation

class CoreDataHelper {
    static let shared:CoreDataHelper = CoreDataHelper()
    
    private init() {}
    
    func fetchPoplulerMovies() -> Movie? {
        let predicate = NSPredicate(format: "isPopular = true")
        guard let fetchResult = CoreDataStack.shared.fetchEntities(entity: MovieInfo.self, predicate: predicate) else { return nil }
        if fetchResult.count > 0 {
            return Movie(page: 0, results: convertToModel(models: fetchResult), total_pages: 1, total_results: 1)
        }
        return nil
    }
    
    func fetchTopRatedMovies() -> Movie? {
        let predicate = NSPredicate(format: "isPopular = false")
        guard let fetchResult = CoreDataStack.shared.fetchEntities(entity: MovieInfo.self, predicate: predicate) else { return nil }
        if fetchResult.count > 0 {
            return Movie(page: 0, results: convertToModel(models: fetchResult), total_pages: 1, total_results: 1)
        }
        return nil
    }
    
    func saveMovies(movies:[MovieInfoModel], isPopular:Bool) {
        for movie in movies {
            self.saveMovie(movie: movie, isPopular: isPopular)
        }
    }
    
    @discardableResult func updateComment(movieId:Int, comment:String) -> Bool {
        let predicate = NSPredicate(format: "id = \(movieId)")
        guard let fetchResult = CoreDataStack.shared.fetchEntities(entity: MovieInfo.self, predicate: predicate) else { return false}
        if let object = fetchResult.first {
            object.comment = comment
            let result = CoreDataStack.shared.saveContext()
            if result == .success {
                return true
            }
        }
        return false
    }
    
    func fetchMovie(movieId:Int) -> MovieInfoModel? {
        let predicate = NSPredicate(format: "id = \(movieId)")
        guard let fetchResult = CoreDataStack.shared.fetchEntities(entity: MovieInfo.self, predicate: predicate) else { return nil}
        let array = self.convertToModel(models: fetchResult)
        if let object = array.first  {
            return object
        }
        return nil
    }
    
    func fetchMovieMCO(movieId:Int) -> MovieInfo? {
        let predicate = NSPredicate(format: "id = \(movieId)")
        guard let fetchResult = CoreDataStack.shared.fetchEntities(entity: MovieInfo.self, predicate: predicate) else { return nil}
        if let object = fetchResult.first  {
            return object
        }
        return nil
    }
    
    @discardableResult func deleteMovie(movieId:Int) -> Bool {
        if let movie = fetchMovieMCO(movieId: movieId) {
            CoreDataStack.shared.managedContext.delete(movie)
            let result = CoreDataStack.shared.saveContext()
            if result == .success {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    @discardableResult func deleteAllMovies() -> Bool {
        return CoreDataStack.shared.deleteAllRecord(entity: MovieInfo.self)
    }

    //NOTE: We can manage to create single class for NSManagedObject and api JSON Model as Codable, means same class satisfy NSManagedObject protocol and Codable protocol
    //  By write convience init and decodaable and encodable functions in a class
    @discardableResult private func saveMovie(movie:MovieInfoModel, isPopular:Bool) -> Bool {
        if isMovieInDB(id: movie.id) == false {
            let object = MovieInfo(context: CoreDataStack.shared.managedContext)
            object.id = Int64(movie.id)
            object.release_date = movie.release_date
            object.vote_average = movie.vote_average
            object.popularity = movie.popularity
            object.title = movie.title
            object.overview = movie.overview
            object.comment = ""
            object.isPopular = isPopular
            object.poster_path = movie.poster_path
            object.comment = ""
            let result = CoreDataStack.shared.saveContext()
            if result == .success {
               return true
            } else {
                return false
            }
        }
        return true
    }
    
    private func convertToModel(models:[MovieInfo]) -> [MovieInfoModel] {
        var result:[MovieInfoModel] = []
        for movie in models {
            result.append(MovieInfoModel(poster_path: movie.poster_path ?? "", release_date: movie.release_date ?? "", vote_average: movie.vote_average, popularity: movie.popularity, id: Int(movie.id), title: movie.title ?? "", overview: movie.overview ?? ""))
        }
        return result
    }
    
    private func isMovieInDB(id:Int) -> Bool {
        let predicate = NSPredicate(format: "id = \(id)")
        return CoreDataStack.shared.isObjectExist(entity: MovieInfo.self, predicate: predicate)
    }
    
}
