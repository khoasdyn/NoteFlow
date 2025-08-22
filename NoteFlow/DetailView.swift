//
//  DetailView.swift
//  NoteFlow
//
//  Created by khoasdyn on 22/8/25.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    let noteID: String
    @Binding var selectedNoteID: String?
    @Environment(\.modelContext) private var modelContext
    @Query private var notes: [Note]
    
    var note: Note? {
        notes.first { $0.id == noteID }
    }
    
    var body: some View {
        if let note = note {
            VStack {
                // Main Container
                VStack(alignment: .leading, spacing: 16) {
                    TextField("Title", text: Binding(
                        get: { note.title },
                        set: { note.title = $0 }
                    ), axis: .vertical)
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(.primary)
                    .textFieldStyle(.plain)
                    .lineLimit(1...10)
                    .multilineTextAlignment(.leading)
                    
                    TextEditor(text: Binding(
                        get: { note.content },
                        set: { note.content = $0 }
                    ))
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
                ToolbarItem(placement: .automatic) {
                    Button {
                        modelContext.delete(note)
                        try? modelContext.save()
                        selectedNoteID = nil
                    } label: {
                        Label("Delete Note", systemImage: "trash")
                    }
                    .tint(.red)
                }
            }
        } else {
            Text("Note not found")
                .foregroundColor(.secondary)
        }
    }
}
