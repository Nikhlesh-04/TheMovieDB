//
//  TextView.swift
//  TheMovieDB
//
//  Created by Nikhlesh bagdiya on 04/07/22.
//

import SwiftUI

struct TextView: View {
    
    @Binding var text:String
    @FocusState var isInputActive: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if self.text.isEmpty {
                    Text("Enter your comment")
                        .font(.body)
                        .padding(EdgeInsets(top: 10, leading: 5, bottom: 0, trailing: 0))
                        .foregroundColor(.gray)
            }
            TextEditor(text: $text)
                .font(.body)
                .opacity(self.text.isEmpty ? 0.25 : 1)
                .textFieldStyle(.roundedBorder)
                                .focused($isInputActive)
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Spacer()
                                        Button("Done") {
                                            isInputActive = false
                                        }
                                    }
                                }
                .onAppear {UITextView.appearance().backgroundColor = .clear}
        }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(text: .constant(""))
    }
}
