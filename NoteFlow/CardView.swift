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
                .foregroundColor(.grayWarm800)
                .lineLimit(3)
            Text(note.content)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.grayWarm700)
                .lineLimit(4)
            Spacer()
        }
        .padding(18)
        .frame(minHeight: 200)
        .frame(maxWidth: .infinity)
        .background(.grayWarm50)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
