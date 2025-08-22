//
//  DetailView.swift
//  NoteFlow
//
//  Created by khoasdyn on 22/8/25.
//

import SwiftUI

struct DetailView: View {
    let note: Note
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
                VStack(alignment: .leading, spacing: 8) {
                    Text(note.title)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.grayWarm800)
                    Text(note.content)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.grayWarm700)
                    Spacer()
                }
                .padding(40)
                .frame(maxWidth: .infinity)
                .background(.grayWarm50)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.5)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                .onTapGesture {
                    // Prevent closing when tapping the card itself
                }
            }
        }
    }
}
