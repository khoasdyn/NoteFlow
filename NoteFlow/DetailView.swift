//
//  DetailView.swift
//  NoteFlow
//
//  Created by khoasdyn on 22/8/25.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Bindable var note: Note
    @Binding var editMode: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Overlay
                Rectangle()
                    .fill(.black.opacity(0.4))
                    .ignoresSafeArea()
                    .onTapGesture {
                        editMode = false
                    }

                // Card View
                VStack(alignment: .leading, spacing: 16) {
                    TextField("Title", text: $note.title, axis: .vertical)
                        .font(.system(size: 28, weight: .medium))
                        .foregroundColor(.primary)
                        .textFieldStyle(.plain)
                        .lineLimit(1...10)
                        .multilineTextAlignment(.leading)
                    
                    TextEditor(text: $note.content)
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
                .padding(32)
                .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.8)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .contentShape(Rectangle())
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
    }
}
