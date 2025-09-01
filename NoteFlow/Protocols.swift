//
//  Protocols.swift
//  NoteFlow
//
//  Created by khoasdyn on 1/9/25.
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
    func restoreFromTrash()
}

extension ActionalableItem {
    func moveToTrash() {
        isInTrash = true
    }
    
    func restoreFromTrash() {
        isInTrash = false
    }
}
