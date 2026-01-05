//
//  NotesList.swift
//  til
//
//  Created by Кирилл Гусев on 04.01.2026.
//

import SwiftUI

struct NotesList: View {

    let viewModel: NotesListViewModel

    @Binding var selectedNote: Note?

    var body: some View {
        List(viewModel.notes, id: \.self, selection: $selectedNote) { note in
            VStack {
                Text(note.date)
            }
            .frame(height: 60)
            .contentShape(.rect)
        }
        .contextMenu(forSelectionType: Note.self) { selection in
            Button("Rename", systemImage: "pencil") {
                
            }
            Button("Delete", systemImage: "trash") {
                Task {
                    await viewModel.deleteNotes(selection)
                }
            }
        }
    }
}
