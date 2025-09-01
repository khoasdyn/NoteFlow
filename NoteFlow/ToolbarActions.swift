//
//  ToolbarActions.swift
//  NoteFlow
//
//  Created by khoasdyn on 1/9/25.
//

import SwiftUI
import SwiftData

extension CardLibraryView {
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
    
    func addNewNote() {
        modelContext.insert(Note(title: "A wonderful new card"))
    }
    
    func recoverAllNotes() {
        for note in notes {
            if note.isInTrash {
                note.isInTrash = false
            }
        }
        try? modelContext.save()
    }
    
    func moveAllToTrash() {
        for note in notes {
            if !note.isInTrash {
                note.isInTrash = true
            }
        }
        try? modelContext.save()
    }
    
    func permanentlDelete() {
        if let selectedNote {
            modelContext.delete(selectedNote)
        }
    }
    
    func permanentlyDeleteAllNotes() {
        for note in notes {
            if note.isInTrash {
                modelContext.delete(note)
            }
        }
        try? modelContext.save()
    }
}
