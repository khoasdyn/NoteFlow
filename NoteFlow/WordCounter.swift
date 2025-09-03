//
//  WordCounter.swift
//  NoteFlow
//
//  Created by khoasdyn on 3/9/25.
//

import SwiftUI

extension DetailView {
    // Computed properties for stats
    var wordCount: Int {
        let words = note.content.split { $0.isWhitespace || $0.isNewline }
        return words.filter { !$0.isEmpty }.count
    }
    
    var characterCount: Int {
        return note.content.count
    }
    
    @ViewBuilder
    func WordCountView() -> some View {
        HStack {
            Text("\(wordCount) \(wordCount == 1 ? "word" : "words")")
                .padding(horizontal: 8, vertical: 4)
                .background(.grayWarm100, in: RoundedRectangle(cornerRadius: .infinity))
                .foregroundStyle(.grayWarm600)
                .font(.callout)
            
            Text("\(characterCount.formatted()) \(characterCount == 1 ? "character" : "characters")")
                .padding(horizontal: 8, vertical: 4)
                .background(.grayWarm100, in: RoundedRectangle(cornerRadius: .infinity))
                .foregroundStyle(.grayWarm600)
                .font(.callout)
        }
    }
}
