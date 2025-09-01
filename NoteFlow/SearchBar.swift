//
//  SearchBar.swift
//  NoteFlow
//
//  Created by khoasdyn on 1/9/25.
//

import SwiftUI
import SwiftData

extension CardLibraryView {   
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
