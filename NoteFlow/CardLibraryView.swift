//
//  CardLibraryView.swift
//  NoteFlow
//
//  Created by khoasdyn on 22/8/25.
//

import SwiftUI
import SwiftData

enum MenuItem {
    case cardLibrary
    case trash
}

struct CardLibraryView: View {
    @Query var notes: [Note]
    @Environment(\.modelContext) private var modelContext
    @State var selectedNote: Note?
    @State private var searchText: String = ""
    @State private var selectedMenuItem: MenuItem = .cardLibrary
    @FocusState private var isSearchFieldFocused: Bool
    
    var body: some View {
        NavigationSplitView {
            VStack(spacing: 0) {
                List {
                    Button(action: { selectedMenuItem = .cardLibrary }) {
                        HStack {
                            Label("Card Library", systemImage: "square.stack")
                                .foregroundStyle(selectedMenuItem == .cardLibrary ? .white : Color.greenLight700)
                            Spacer()
                            Text("\(notes.filter { !$0.isInTrash }.count)")
                                .font(.caption)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.greenLight700, in: Capsule())
                                .contentTransition(.numericText())
                                .animation(.snappy, value: notes.count)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selectedMenuItem == .cardLibrary ? Color.greenLight500 : Color.greenLight50, in: RoundedRectangle(cornerRadius: 8))
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: { selectedMenuItem = .trash }) {
                        HStack {
                            Label("Trash", systemImage: "trash")
                                .foregroundStyle(selectedMenuItem == .trash ? .white : Color.error700)
                            Spacer()
                            Text("\(notes.filter { $0.isInTrash }.count)")
                                .font(.caption)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.error700, in: Capsule())
                                .contentTransition(.numericText())
                                .animation(.snappy, value: notes.count)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selectedMenuItem == .trash ? Color.error500 : Color.error50, in: RoundedRectangle(cornerRadius: 8))
                    }
                    .buttonStyle(.plain)
                }
            }
        } detail: {
            if let note = selectedNote {
                DetailView(note: note, selectedMenuItem: selectedMenuItem) {
                    withAnimation {
                        selectedNote?.restoreFromTrash()
                    }
                    selectedNote = nil
                } onDeletePermanently: {
                    withAnimation {
                        permanentlDelete()
                    }
                    selectedNote = nil
                }
            } else {
                SearchQueryView(searchText: searchText) { notes in
                    let filteredNotes = notes.filter { selectedMenuItem == .cardLibrary ? !$0.isInTrash : $0.isInTrash }
                    ScrollView(.vertical) {
                        SearchBar()
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 200), spacing: 16)], spacing: 16) {
                            ForEach(filteredNotes, id: \.id) { note in
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
                    .scrollContentBackground(.hidden)
                    .scrollIndicators(.never)
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
            toolbarContent(isSearching: isSearchFieldFocused || !searchText.isEmpty, selectedMenuItem: selectedMenuItem)
        }
        .task {
            // Small delay to prevent auto-focus on launch
            try? await Task.sleep(for: .seconds(0.1))
            isSearchFieldFocused = false
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
        .frame(maxWidth: 400)
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
    
    func recoverAllNotes() {
        for note in notes {
            if note.isInTrash {
                note.isInTrash = false
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

#Preview {
    CardLibraryView()
}
