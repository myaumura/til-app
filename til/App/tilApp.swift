//
//  tilApp.swift
//  til
//
//  Created by Кирилл Гусев on 03.01.2026.
//

import SwiftUI
import SQLiteData
import Dependencies
import OSLog
import PathKit

@main
struct tilApp: App {

    private let logger = Logger(subsystem: "til-app", category: "Database")

    init() {
        prepareDependencies {
            $0.defaultDatabase = try! appDatabase()
        }
        
        createFileStorage()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowToolbarStyle(.unified)

        Window("New Note", id: "note") {
            NoteView(viewModel: NoteViewModel())
        }
    }
    
    func createFileStorage() {
        let markdownFolder = Path.home + "Markdowns"
        
        if !markdownFolder.exists {
            do {
                try markdownFolder.mkdir()
            } catch {
                print("Error with creating folder: \(error)")
            }
        }
        
        #if DEBUG
        print("Markdown folder: \(markdownFolder.string)")
        #endif
    }

    func appDatabase() throws -> any DatabaseWriter {
        @Dependency(\.context) var context

        var configuration = Configuration()
        configuration.foreignKeysEnabled = true

#if DEBUG
        configuration.prepareDatabase { db in
            db.trace(options: .profile) {
                logger.debug("\($0.expandedDescription)")
            }
        }
#endif

        let database = try defaultDatabase(configuration: configuration)
        let path = Path.home + "Documents" + "db.sqlite"
        logger.info("Open \(path)")

        var migrator = DatabaseMigrator()

#if DEBUG
        migrator.eraseDatabaseOnSchemaChange = true
#endif

        migrator.registerMigration("Notes table") { db in
            try db.create(table: "notes") { table in
                table.column("id", .any)
                table.column("date", .text)
                table.column("file", .text)
            }
        }

        try migrator.migrate(database)
        return database
    }
}
