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
    @Environment(\.modelContext) var modelContext
    @State var selectedNote: Note?
    @State var searchText: String = ""
    @State var selectedMenuItem: MenuItem = .cardLibrary
    @FocusState var isSearchFieldFocused: Bool
    
    var body: some View {
        NavigationSplitView {
            VStack(spacing: 0) {
                List {
                    CardLibraryMenuItem()
                    TrashMenuItem()
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
}

#Preview {
    CardLibraryView()
}
