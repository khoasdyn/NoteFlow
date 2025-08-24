//
//  ContentView.swift
//  NoteFlow
//
//  Created by khoasdyn on 22/8/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var notes: [Note]
    @Environment(\.modelContext) private var modelContext
    @State var selectedNote: Note?
    @State private var searchText: String = ""
    @FocusState private var isSearchFieldFocused: Bool
    
    var body: some View {
        NavigationSplitView {
            List {
                Label("All Cards", systemImage: "square.stack")
            }
        } detail: {
            if let note = selectedNote {
                DetailView(note: note)
            } else {
                SearchQueryView(searchText: searchText) { notes in
                    ScrollView(.vertical) {
                        SearchBar()
                            .frame(maxWidth: 400)
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 200), spacing: 16)], spacing: 16) {
                            ForEach(notes, id: \.id) { note in
                                CardView(note: note)
                                    .onTapGesture {
                                        selectedNote = note
                                    }
                            }
                        }
                        .padding(16)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .onTapGesture {
                        // Dismiss search focus when tapping outside
                        isSearchFieldFocused = false
                    }
                    .onKeyPress(.escape) {
                        // Dismiss search focus when pressing Escape key
                        isSearchFieldFocused = false
                        if !searchText.isEmpty {
                            searchText = ""
                        }
                        return .handled
                    }
                }
            }
        }
        .toolbar {
            toolbarContent(isSearching: isSearchFieldFocused || !searchText.isEmpty)
        }
    }
    
    /// Custom Search Bar With Some Basic Components
    @ViewBuilder
    func SearchBar() -> some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
            
            TextField("Search", text: $searchText)
                .textFieldStyle(.plain)
                .focused($isSearchFieldFocused)
            
            // Clear button
            if !searchText.isEmpty || isSearchFieldFocused {
                Button(action: {
                    searchText = ""
                    isSearchFieldFocused = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(Color.primary.opacity(0.06), in: .rect(cornerRadius: 10))
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
    
    func addNewNote() {
        modelContext.insert(Note(title: "A wonderful new card"))
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
