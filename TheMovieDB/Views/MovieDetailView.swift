//
//  MovieDetailView.swift
//  TheMovieDB
//
//  Created by Nikhlesh bagdiya on 03/07/22.
//

import SwiftUI
import SDWebImageSwiftUI
import KeyboardAvoider
import SimpleToast
import YouTubePlayerKit

struct MovieDetailView: View {
    
    @ObservedObject private var model:MovieDetailViewModel
    @State private var text: String = ""
    @State var showToast: Bool = false
    @State var hudConfig = LoadingViewConfig()
    @State private var isPresented = false
    
    private let progressView:Image = Image(ConstantImage.moviePlaceholder)
    
    init(movie:MovieInfoModel) {
        self.model = MovieDetailViewModel(movie: movie)
    }
    
    var body: some View {
        LoadingView(isShowing: $model.hudVisible, config: hudConfig) {
            ScrollView {
                VStack {
                    
                    self.topView()
                    
                    Text("OverView:\n\(model.movie.overview)")
                        .bold()
                        .font(.body)
                        .foregroundColor(Color(.systemGray))
                    
                    TextView(text: $text)
                        .frame(minHeight: 50, maxHeight: 150)
                        .background(Color(UIColor.secondarySystemBackground))
                        .onAppear {
                            self.text = model.movie.comment
                        }
                    
                    self.commentButtonView()
                    
                    self.trailorButtonView()
                        .sheet(isPresented: $isPresented) {
                            let player =  YouTubePlayer(source: .video(id: model.videoYoutubeId), configuration: .init(
                                autoPlay: true
                            ))
                        YouTubePlayerView(player)
                    }
                    
                }
                .avoidKeyboard()
            }
            .simpleToast(isPresented: $showToast, options: Constants.toastOptions) {
                ToastContent(text: ConstantsMessages.comment)
            }
            .padding()
            .navigationTitle(model.movie.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func topView() -> some View {
        HStack(alignment: .top) {
            let url = URL(string: TheMovieDB.imageBaseURL + (model.movie.poster_path ?? ""))
            WebImage(url: url)
                .placeholder {
                    progressView
                        .resizable()
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 150, maxWidth: 150)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(model.movie.title)
                    .bold()
                    .font(.title3)
                
                Text("Release Date")
                    .bold()
                    .font(.title3)
                    .foregroundColor(Color(.systemGray))
                    .padding(.vertical,3)
                
                Text(model.movie.displayDate)
                    .bold()
                    .foregroundColor(Color(.systemGray))
                    .padding(.bottom,5)
                
                Text("⭐️ Rating")
                    .bold()
                    .font(.title3)
                    .foregroundColor(Color(.systemGray))
                    .padding(.vertical,3)
                
                Text("\(model.movie.vote_average)")
                    .bold()
                    .foregroundColor(Color(.systemGray))
                    .padding(.bottom,5)
                
            }
        }
    }
    
    func trailorButtonView() -> some View {
        VStack {
            Button(action: {
                UIApplication.shared.endEditing()
                self.isPresented = true
            }) {
                HStack {
                    Image(systemName: ConstantImage.watchTralior)
                        .renderingMode(.template)
                        .foregroundColor(ColourStyle.shared.colorScheme == .light ? Color.white : Color.black)
                    Text("Watch Trailer")
                        .font(.system(size: 23))
                        .foregroundColor(ColourStyle.shared.colorScheme == .light ? Color.white : Color.black)
                    
                }
                .padding(EdgeInsets(top: 10, leading: 50, bottom: 10, trailing: 50))
                .background(ColourStyle.shared.colorScheme == .light ? Color.black : Color.white)
                .clipShape(Capsule())
            }
        }
    }
    
    func commentButtonView() -> some View {
        VStack {
            Button(action: {
                if text.count > 0 {
                    withAnimation {
                        showToast.toggle()
                    }
                    self.model.commentSave(text: text, id: model.movie.id)
                    UIApplication.shared.endEditing()
                }
            }) {
                HStack {
                    Spacer()
                    Text("Comment")
                        .font(.system(size: 18))
                        .foregroundColor(.blue)
                    
                }
                .padding(EdgeInsets(top: 3, leading: 50, bottom: 10, trailing: 10))
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(Constants.typeSizes, id: \.self) { size in
                MovieDetailView(movie: MovieInfoModel())
                    .environment(\.dynamicTypeSize, size)
                    .previewDisplayName("\(size)")
            }
            MovieDetailView(movie: MovieInfoModel())
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("dark")
        }.previewLayout(.sizeThatFits)
    }
}
