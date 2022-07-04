//
//  MovieDetailViewModel.swift
//  TheMovieDB
//
//  Created by Nikhlesh bagdiya on 03/07/22.
//

import Combine
import SwiftUI
import Foundation

final class MovieDetailViewModel: ObservableObject {
    
    @Published var hudVisible:Bool = true
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    @Published private(set) var movie:MovieInfoModel
    private var videos:Videos = Videos()
    private(set) var videoYoutubeId:String   = ""
        
    init(movie:MovieInfoModel) {
        self.movie = movie
        fetch()
    }
    
    private func fetch() {
        APIService.shared.getVideos(movieId: movie.id) { videos, error in
            self.hudVisible = false
            if let videoss = videos {
                self.videos = videoss
                if let first = videoss.results.first {
                    self.videoYoutubeId = first.key
                }
            } else if let error = error {
                self.isErrorShown = true
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func commentSave(text:String, id:Int) {
        CoreDataHelper.shared.updateComment(movieId: id, comment: text)
    }
}


