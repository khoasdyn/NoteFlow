//
//  DetailView.swift
//  NoteFlow
//
//  Created by khoasdyn on 22/8/25.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Bindable var note: Note
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack {
            // Main Container
            VStack(alignment: .leading, spacing: 16) {
                TextField("Title", text: $note.title, axis: .vertical)
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(.primary)
                    .textFieldStyle(.plain)
                    .lineLimit(1...10)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: 650)
                
                TextEditor(text: $note.content)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.primary)
                    .frame(maxHeight: .infinity, alignment: .topLeading)
                    .scrollContentBackground(.hidden)
                    .scrollIndicators(.never)  // Hides the scroll bar
                    .frame(maxWidth: 650)
            }
            .padding(32)
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
        }
        .padding(32)
        .navigationTitle(note.title)
    }
}
