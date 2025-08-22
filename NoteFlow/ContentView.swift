//
//  ContentView.swift
//  NoteFlow
//
//  Created by khoasdyn on 22/8/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    let columns = [GridItem(.adaptive(minimum: 200), spacing: 16)]

    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 16) {
                    CardView(note: Note(title: "Grocery List for Weekend Shopping"))
                    CardView(note: Note(title: "Hello World"))
                    CardView(note: Note(title: "Notes from Monday Team Meeting"))
                    CardView(note: Note(title: "Brainstorming Project Ideas for Q3"))
                    CardView(note: Note(title: "Personal Information"))
                    CardView(note: Note(title: "Detailed Travel Plans for Japan Trip"))
                }
                .padding(16)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
    }
}

struct CardView: View {
    let note: Note
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(note.title)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.yellow900)
//            Text("Description here")
            Spacer()
        }
        .padding()
        .frame(minHeight: 200)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(.yellow100)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    ContentView()
}
