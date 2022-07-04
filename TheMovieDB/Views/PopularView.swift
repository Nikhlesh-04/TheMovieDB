//
//  PopularView.swift
//  TheMovieDB
//
//  Created by Nikhlesh bagdiya on 02/07/22.
//

import SwiftUI
import SimpleToast

struct PopularView: View {
    @EnvironmentObject var state: AppState
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject private var model = PopularViewModel()
    @State var hudConfig = LoadingViewConfig()
    
    var body: some View {
        LoadingView(isShowing: $model.hudVisible, config: hudConfig) {
            NavigationView {
                ZStack {
                    VStack {
                        List {
                            ForEach(0..<model.moviesCount, id:\.self) { index in
                                let movie = model.getMovie(index: index)
                                NavigationLink(destination: MovieDetailView(movie: movie)){
                                    let url = URL(string: TheMovieDB.imageBaseURL + (movie.poster_path ?? ""))
                                    MovieCellView(image: url, title: movie.title, releaseDate: movie.displayDate)
                                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 10))
                                        .onAppear {
                                            model.checkAndHandleIfPaginationRequired(at: index)
                                        }
                                }
                            }
                        }
                        .accessibilityIdentifier(Identifiers.popularTable)
                        
                        if model.isLoading {
                            ProgressView()
                                .padding()
                        }
                    }
                    .background(Color(UIColor.secondarySystemBackground))
                }
                .simpleToast(isPresented: $model.noMoreLoading, options: Constants.toastOptions) {
                        ToastContent(text: ConstantsMessages.noMoreScroll)
                    }
                .navigationTitle(ConstantsMessages.navigationPopularTitle)
                .toolbar {
                    LogoutButton()
                }
            }
        }.padding(.top, 1)
    }
}

struct PopularView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(Constants.typeSizes, id: \.self) { size in
                PopularView()
                    .environment(\.dynamicTypeSize, size)
                    .previewDisplayName("\(size)")
            }
            PopularView()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("dark")
        }.previewLayout(.sizeThatFits)
    }
}
