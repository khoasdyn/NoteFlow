//
//  ContentView.swift
//  NoteFlow
//
//  Created by khoasdyn on 22/8/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var notes: [Note]
    
    @State var selectedNote: Note?
    @State var editMode: Bool = false
    
    let columns = [GridItem(.adaptive(minimum: 200), spacing: 16)]
    
    var body: some View {
        ScrollView(.vertical) {
            HStack {
                Button("Add Sample") {
                    addSampledNotes()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Add new Note") {
                    modelContext.insert(Note(title: "A wonderful new card"))
                }
                .buttonStyle(.borderedProminent)
                
                Button("Delete All") {
                    deleteAllNotes()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(notes, id: \.id) { note in
                    CardView(note: note)
                        .onTapGesture {
                            selectedNote = note
                            editMode = true
                        }
                }
            }
            .padding(16)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .overlay {
            if editMode, let selected = selectedNote {
                DetailView(note: selected, editMode: $editMode)
            }
        }
    }
    
    func addSampledNotes() {
        let titles = [
            "Grocery List for Weekend Shopping",
            "Hello World",
            "Notes from Monday Team Meeting",
            "Notes from Monday Team Meeting",
            "Summary of Monday Team Meeting Action Items",
            "Follow-up Tasks from Monday Team Meeting",
            "Decisions Made During Monday Team Meeting",
            "Attendees and Absentees - Monday Team Meeting",
            "Monday Team Meeting: Discussion Points",
            "Monday Team Meeting: Next Steps",
            "Monday Team Meeting: Open Questions",
            "Monday Team Meeting: Feedback and Suggestions",
            "Monday Team Meeting: Deadlines and Deliverables",
            "Monday Team Meeting: Miscellaneous Notes",
            "Notes from Monday Team Meeting",
            "Brainstorming Project Ideas for Q3",
            "Personal Information",
            "Detailed Travel Plans for Japan Trip"
        ]
        for title in titles {
            modelContext.insert(Note(title: title))
        }
    }
    
    func deleteAllNotes() {
        for note in notes {
            modelContext.delete(note)
        }
        try? modelContext.save()
    }
}

#Preview {
    ContentView()
}
