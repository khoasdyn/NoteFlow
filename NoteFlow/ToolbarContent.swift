//
//  ToolbarContent.swift
//  NoteFlow
//
//  Created by khoasdyn on 24/8/25.
//

import SwiftUI
import SwiftData

extension CardLibraryView {
    @ToolbarContentBuilder
    func toolbarContent(isSearching: Bool, selectedMenuItem: MenuItem, notes: [Note]) -> some ToolbarContent {
        if selectedNote != nil {
            // DetailView toolbar items
            ToolbarItemGroup(placement: .navigation) {
                Button {
                    selectedNote = nil
                } label: {
                    Label("Back", systemImage: "chevron.left")
                }
            }
            
            ToolbarItemGroup(placement: .primaryAction) {
                if selectedMenuItem != .trash {
                    Button {
                        withAnimation {
                            selectedNote?.moveToTrash()
                        }
                        selectedNote = nil

                    } label: {
                        Label("Move To Trash", systemImage: "trash")
                    }
                }

            }
        } else if !isSearching {
            // Grid view toolbar items - only show when not searching
            ToolbarItemGroup {
                if selectedMenuItem == .cardLibrary {
                    
                    Button {
                        addNewNote()
                    } label: {
                        Image(systemName: "plus.square")
                    }
                    
                    Menu {
                        Button {
                            addSampledNotes()
                        } label: {
                            Label("Add Sample Notes", systemImage: "wand.and.sparkles.inverse")
                        }
                        
                        Divider()
                        
                        Button {
                            moveAllToTrash()
                        } label: {
                            Label("Delete All", systemImage: "trash")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                    
                } else if selectedMenuItem == .trash {
                    let trashCount = notes.filter { $0.isInTrash }.count
                    Menu {
                        Button {
                            recoverAllNotes()
                        } label: {
                            Label("Recover All Notes", systemImage: "arrow.up.trash")
                        }
                        .disabled(trashCount == 0)
                        
                        Divider()
                        
                        Button {
                            showDeleteConfirmation = true
                        } label: {
                            Label("Delete All Permanently...", systemImage: "trash")
                        }
                        .disabled(trashCount == 0)
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
        }
    }
}
