//
//  NotesListViewModel.swift
//  til
//
//  Created by Кирилл Гусев on 05.01.2026.
//

import Dependencies
import SQLiteData
import Observation
import PathKit

@Observable
final class NotesListViewModel {

    @ObservationIgnored
    @FetchAll
    var notes: [Note]

    @ObservationIgnored
    @Dependency(\.defaultDatabase)
    private var database

    func deleteNote(_ note: Note) async {
        do {
            try await database.write { db in
                try Path(note.file).delete()
                
                try Note.delete(note)
                    .execute(db)
            }
        } catch {
            print("Error with deleting note from db")
        }
    }

    func deleteNotes(_ notes: Set<Note>) async {
        do {
            for note in notes {
                try Path(note.file).delete()
                
                try await database.write { db in
                    try Note.delete(note)
                        .execute(db)
                }
            }
        } catch {
            print("Error with deleting notes from db")
        }
    }
}
