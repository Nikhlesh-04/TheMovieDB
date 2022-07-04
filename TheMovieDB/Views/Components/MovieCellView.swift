//
//  MovieCellView.swift
//  TheMovieDB
//
//  Created by Nikhlesh bagdiya on 03/07/22.
//

import SwiftUI
import Combine
import Foundation
import SDWebImageSwiftUI

struct MovieCellView: View {
    var image: URL?
    var title:String
    var releaseDate:String
    
    private let progressView:Image = Image(ConstantImage.moviePlaceholder)
    
    var body: some View {
        ZStack {
            HStack {
                VStack {
                    WebImage(url: image)
                        .placeholder {
                            progressView
                                .resizable()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }
                .frame(minWidth: 50, maxWidth: 100)
                .cornerRadius(8)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .bold()
                        .padding(.vertical,3)
                    Text(releaseDate)
                        .bold()
                        .font(.body)
                        .foregroundColor(Color(.systemGray))
                }
            }
        }
    }
}

struct MovieCellView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(Constants.typeSizes, id: \.self) { size in
                MovieCellView(title: "Men VS Wild", releaseDate: "May 10, 2021")
                    .environment(\.dynamicTypeSize, size)
                    .previewDisplayName("\(size)")
            }
            MovieCellView(title: "Men VS Wild", releaseDate: "May 10, 2021")
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("dark")
        }.previewLayout(.sizeThatFits)
    }
}
