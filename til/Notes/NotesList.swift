//
//  NotesList.swift
//  til
//
//  Created by Кирилл Гусев on 04.01.2026.
//

import SwiftUI
import Dependencies
import SQLiteData

struct NotesList: View {

    @FetchAll
    var notes: [Note]

    @Binding var selectedNote: Note?

    var body: some View {
        List(notes, id: \.self, selection: $selectedNote) { note in
            VStack {
                Text(note.date)
            }
            .frame(height: 60)
            .contentShape(.rect)
        }
        .onChange(of: selectedNote, { oldValue, newValue in
            print("Selection changed from \(String(describing: oldValue)) to: \(String(describing: newValue))")
        })
    }
}
