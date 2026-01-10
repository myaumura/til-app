//
//  ContentView.swift
//  til
//
//  Created by Кирилл Гусев on 03.01.2026.
//

import SwiftUI
import Dependencies
import GRDB
import StructuredQueriesCore
import SQLiteData
import PathKit

struct ContentView: View {

    @Environment(\.openWindow) private var openWindow

    @State private var selectedNote: Note?

    var body: some View {
        NavigationSplitView {
            List {
                Text("Learned")
                Text("Todo")
            }
        } content: {
            NotesList(viewModel: NotesListViewModel(), selectedNote: $selectedNote)
        } detail: {
            DetailView()
        }
        .navigationSplitViewStyle(.balanced)
        .toolbar {
            Button("", systemImage: "plus") {
                openWindow(id: "note")
            }
        }
        .toolbar {
            Button("", systemImage: "folder") {
                let path = PathKit.Path.home + "Markdowns"
                NSWorkspace.shared.open(path.url)
            }
        }
    }
    
    @ViewBuilder
    private func DetailView() -> some View {
        if let selectedNote {
            let viewModel = NoteDetailViewModel(note: selectedNote)
            NoteDetailView(viewModel: viewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        } else {
            ContentUnavailableView("Select the note!", systemImage: "note")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}

#Preview {
    ContentView()
}
