//
//  Note.swift
//  NoteFlow
//
//  Created by khoasdyn on 22/8/25.
//
import SwiftUI
import SwiftData

@Model
class Note {
    var id: String = UUID().uuidString
    var title: String
    var content: String
    
    init(title: String) {
        self.title = title
        self.content = ""
    }
}
