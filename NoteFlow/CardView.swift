//
//  CardView.swift
//  NoteFlow
//
//  Created by khoasdyn on 22/8/25.
//

import SwiftUI

struct CardView: View {
    let note: Note
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(note.title)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(Color(red: 0.45, green: 0.33, blue: 0.04))
                .lineLimit(3)
            Text(note.content)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.gray)
                .lineLimit(4)
            Spacer()
        }
        .padding()
        .frame(minHeight: 200)
        .frame(maxWidth: .infinity)
        .background(Color(red: 1.0, green: 0.98, blue: 0.88))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
