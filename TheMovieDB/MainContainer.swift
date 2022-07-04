//
//  MainContainer.swift
//  TheMovieDB
//
//  Created by Nikhlesh bagdiya on 02/07/22.
//

import SwiftUI

struct MainContainer: View {
    
    @EnvironmentObject var state: AppState
    @State var hudConfig = LoadingViewConfig()
    
    var body: some View {
        TabView {
            PopularView()
                .tabItem {
                    Label(ConstantsMessages.popularTab, systemImage: ConstantImage.popular)
                }
            TopRatedView()
                .tabItem {
                    Label(ConstantsMessages.topRatedTab, systemImage: ConstantImage.topRated)
                }
        }.accentColor(.primary)
    }
}

struct MainContainer_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            ForEach(Constants.typeSizes, id: \.self) { size in
                MainContainer()
                    .environment(\.dynamicTypeSize, size)
                    .previewDisplayName("\(size)")
            }
            MainContainer()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("dark")
        }.previewLayout(.sizeThatFits)
    }
}

