//
//  NoteViewModel.swift
//  til
//
//  Created by Кирилл Гусев on 04.01.2026.
//

import Dependencies
import PerceptionCore
import Foundation
import GRDB
import StructuredQueriesCore
import SQLiteData
import Markdown
import PathKit
import SwiftUI

@Observable
final class NoteViewModel {

    @ObservationIgnored
    @FetchAll
    var notes: [Note]

    @ObservationIgnored
    @Dependency(\.uuid) private var uuid
    
    @ObservationIgnored
    @Dependency(\.defaultDatabase) var database
    
    func createNote(date: Date, body: String) async throws -> Bool {
        
        let formattedDate = date.formatted(date: .numeric, time: .omitted)
        
        let filePath = Path.home + "Markdowns" + "\(formattedDate).md"

        let note = Note(id: uuid(), date: formattedDate, file: filePath.string)
        
        guard !notes.contains(where: { $0.file == filePath.string || $0.date == formattedDate }) else { return false }
                
        try await database.write { db in
            try Note.insert { note }
                .execute(db)
        }
                
        try filePath.write(body)
        return true
    }
}
