//
//  SideMenuItems.swift
//  NoteFlow
//
//  Created by khoasdyn on 1/9/25.
//

import SwiftUI
import SwiftData

extension CardLibraryView {
    @ViewBuilder
    func CardLibraryMenuItem() -> some View {
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
    }
    
    @ViewBuilder
    func TrashMenuItem() -> some View {
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
