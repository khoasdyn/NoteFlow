//
//  DetailView.swift
//  NoteFlow
//
//  Created by khoasdyn on 22/8/25.
//

import SwiftUI

struct DetailView: View {
    let note: Note
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black.opacity(0.4))
                .ignoresSafeArea()
            
            CardView(note: note)
                .frame(maxWidth: 500, maxHeight: 400)
        }
    }
}
