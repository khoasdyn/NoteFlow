//
//  Note.swift
//  NoteFlow
//
//  Created by khoasdyn on 22/8/25.
//
import SwiftUI
import SwiftData

protocol DisplayableItem {
    var id: String { get }
    var title: String { get set }
    var content: String { get set }
    var dateCreated: Date { get }
}

protocol ActionalableItem: AnyObject {
    var isInTrash: Bool { get set }
    func moveToTrash()
    func recoverFromTrash()
}

extension ActionalableItem {
    func moveToTrash() {
        isInTrash = true
    }
    
    func recoverFromTrash() {
        isInTrash = false
    }
}

@Model
class Note: DisplayableItem, ActionalableItem {
    var id: String = UUID().uuidString
    var title: String
    var content: String
    var dateCreated: Date = Date()
    var isInTrash: Bool = false
    
    init(title: String) {
        self.title = title
        self.content = ""
    }
}
