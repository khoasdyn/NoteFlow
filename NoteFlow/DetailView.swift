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
    @FocusState private var isTextEditorFocused: Bool
    let selectedMenuItem: MenuItem
    
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
                    .padding(.leading, 5)
                    .allowsHitTesting(selectedMenuItem != .trash)
                
                TextEditor(text: $note.content)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.primary)
                    .frame(maxHeight: .infinity, alignment: .topLeading)
                    .scrollContentBackground(.hidden)
                    .scrollIndicators(.never)
                    .focused($isTextEditorFocused)
                    .disabled(selectedMenuItem == .trash)
            }
            .padding(32)
            .frame(maxWidth: 800)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
        }
        .padding(48)
        .navigationTitle(note.title)
        .task {
            // Auto-focus TextEditor only when content is empty and not in trash
            if note.content.isEmpty && selectedMenuItem != .trash {
                try? await Task.sleep(for: .seconds(0.1))
                isTextEditorFocused = true
            }
        }
    }
}
