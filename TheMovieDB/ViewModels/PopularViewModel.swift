//
//  PopularViewModel.swift
//  TheMovieDB
//
//  Created by Nikhlesh bagdiya on 03/07/22.
//

import Combine
import SwiftUI
import Foundation

final class PopularViewModel: ObservableObject {
    
    @Published var hudVisible:Bool = true
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    @Published var isLoading = false
    @Published var noMoreLoading = false
    @Published private var movies = Movie()
    @Published private(set) var moviesArray:[MovieInfoModel]  = []
    
    private var currentPageNumber: Int = 1
    
    init() {fetch(page:currentPageNumber)}

    private func fetch(page:Int) {
        APIService.shared.getPopularMovies(page: page) { popularMoviesObject, error in
            self.hudVisible = false
            self.isLoading = false
            if let popular = popularMoviesObject {
                self.setupDataSource(movies: popular)
                self.saveDataToCoreDataForCache(movies: popular)
            } else if let error = error {
                self.isErrorShown = true
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    private func setupDataSource(movies:Movie) {
        self.movies = movies
        var  filteredList:[MovieInfoModel] = []
        for item in movies.results {
            if self.moviesArray.contains(where: {$0.id == item.id}) == false {
                filteredList.append(item)
            }
        }
        self.moviesArray = self.moviesArray + filteredList
        self.currentPageNumber = self.movies.page
        
        if movies.results.count == 0 {
            self.noMoreLoading = true
        }
    }
    
    func saveDataToCoreDataForCache(movies:Movie) {
        CoreDataHelper.shared.saveMovies(movies: movies.results, isPopular: true)
    }
    
    var moviesCount:Int {
        return self.moviesArray.count
    }
    
    func getMovie(index: Int) -> MovieInfoModel {
        let array = moviesArray[index]
        return array
    }
    
    func checkAndHandleIfPaginationRequired(at row: Int) {
        print(row)
        if (row + 1 == moviesArray.count) && (currentPageNumber != movies.total_pages) {
            handlePaginationRequired()
        }
    }
    
    private func handlePaginationRequired() {
        if !isLoading && currentPageNumber != 0 {
            isLoading = true
            self.fetch(page: currentPageNumber + 1)
        }
    }
}
