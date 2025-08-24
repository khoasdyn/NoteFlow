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
    func toolbarContent(isSearching: Bool) -> some ToolbarContent {
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
                    // Share action
                } label: {
                    Label("Share", systemImage: "square.and.arrow.up")
                }
            }
        } else if !isSearching {
            // Grid view toolbar items - only show when not searching
            ToolbarItemGroup {
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
                    deleteAllNotes()
                } label: {
                    Image(systemName: "trash")
                }
                .tint(.red)
            }
        }
    }
}
