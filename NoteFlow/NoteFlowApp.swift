//
//  NoteFlowApp.swift
//  NoteFlow
//
//  Created by khoasdyn on 22/8/25.
//

import SwiftUI
import SwiftData

@main
struct NoteFlowApp: App {
    var body: some Scene {
        WindowGroup {
            CardLibraryView()
                .modelContainer(for: Note.self)
                .preferredColorScheme(.light)
        }
    }
}
