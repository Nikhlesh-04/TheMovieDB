//
//  ToastContent.swift
//  TheMovieDB
//
//  Created by Nikhlesh bagdiya on 04/07/22.
//

import SwiftUI

struct ToastContent: View {
    
    var text:String
    
    var body: some View {
        HStack {
            Text(text)
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(Color.white)
        .cornerRadius(10)
    }
}

struct ToastContent_Previews: PreviewProvider {
    static var previews: some View {
        ToastContent(text: "This is some simple toast message.")
    }
}
