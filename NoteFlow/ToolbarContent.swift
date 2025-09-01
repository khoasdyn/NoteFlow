//
//  ToolbarContent.swift
//  NoteFlow
//
//  Created by khoasdyn on 24/8/25.
//

import SwiftUI
import SwiftData

extension ContentView {
    @ToolbarContentBuilder
    func toolbarContent(isSearching: Bool, selectedMenuItem: MenuItem) -> some ToolbarContent {
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
                Button {
                    moveToTrash()
                    selectedNote = nil
                } label: {
                    Label("Delete Note", systemImage: "trash")
                }
            }
        } else if !isSearching {
            // Grid view toolbar items - only show when not searching
            ToolbarItemGroup {
                if selectedMenuItem == .cardLibrary {
                    Button {
                        addSampledNotes()
                    } label: {
                        Image(systemName: "wand.and.sparkles.inverse")
                    }
                    
                    Button {
                        addNewNote()
                    } label: {
                        Image(systemName: "plus.square")
                    }
                    
                    Button {
                        moveToTrash()
                    } label: {
                        Image(systemName: "trash")
                    }
                    .tint(.red)
                } else if selectedMenuItem == .trash {
                    Button {
                        recoverAllNotes()
                    } label: {
                        Image(systemName: "arrow.up.trash")
                    }
                    .tint(.green)
                    
                    Button {
                        permanentlyDeleteAllNotes()
                    } label: {
                        Image(systemName: "trash")
                    }
                    .tint(.red)
                }
            }
        }
    }
}
