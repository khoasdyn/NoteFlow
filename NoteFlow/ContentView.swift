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
                    CardView(note: Note(title: "Notes from Monday Team Meeting"))
                    CardView(note: Note(title: "Summary of Monday Team Meeting Action Items"))
                    CardView(note: Note(title: "Follow-up Tasks from Monday Team Meeting"))
                    CardView(note: Note(title: "Decisions Made During Monday Team Meeting"))
                    CardView(note: Note(title: "Attendees and Absentees - Monday Team Meeting"))
                    CardView(note: Note(title: "Monday Team Meeting: Discussion Points"))
                    CardView(note: Note(title: "Monday Team Meeting: Next Steps"))
                    CardView(note: Note(title: "Monday Team Meeting: Open Questions"))
                    CardView(note: Note(title: "Monday Team Meeting: Feedback and Suggestions"))
                    CardView(note: Note(title: "Monday Team Meeting: Deadlines and Deliverables"))
                    CardView(note: Note(title: "Monday Team Meeting: Miscellaneous Notes"))
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
        VStack(alignment: .leading, spacing: 8) {
            Text(note.title)
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.yellow900)
                .lineLimit(3)
            Text(note.content)
                .multilineTextAlignment(.leading)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.grayWarm500)
                .lineLimit(4)
            Spacer()
        }
        .padding()
        .frame(minHeight: 200)
        .frame(maxWidth: .infinity)
        .background(.yellow100)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    ContentView()
}
