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
                
                TextEditor(text: $note.content)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .scrollContentBackground(.hidden)
            }
            .padding(32)
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(32)
        .frame(maxWidth: 800, maxHeight: .infinity)
        .navigationTitle(note.title)
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button {
                   
                } label: {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
            }
        }
    }
}
