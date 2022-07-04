//
//  LoadingViewConfig.swift
//  TheMovieDB
//
//  Created by Nikhlesh bagdiya on 02/07/22.
//

import Foundation
import SwiftUI

struct LoadingViewConfig: Hashable {
    var title: String?
    var backgroundColor: Color
    var spinnerColor: Color

    public init(
        title: String?                  = nil,
        backgroundColor: Color          = .clear,
        spinnerColor: Color             = .blue
        
    ) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.spinnerColor = spinnerColor
    }
}
