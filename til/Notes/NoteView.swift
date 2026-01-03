//
//  NoteView.swift
//  til
//
//  Created by Кирилл Гусев on 04.01.2026.
//

import SwiftUI
import Foundation

struct NoteView: View {

    var viewModel: NoteViewModel

    @Environment(\.dismissWindow) private var dismissWindow

    @State private var date: Date = .now
    
    @State private var text: String = ""

    var body: some View {
        VStack {
            Form {
                Section("Date Picker") {
                    DatePicker(selection: $date, in: ...Date.now, displayedComponents: .date) {
                        Text("Select a date")
                    }
                }

                TextField("Type some text", text: $text)

                Button {
                    var success = false
                    
                    Task {
                        do {
                            success = try await viewModel.createNote(date: date, body: text)
                        } catch {
                            print("Error with creating note after tap: \(error)")
                        }
                    }

                    success ? dismissWindow(id: "note") : print("Error with closing window!")

                } label: {
                    Label("Add", systemImage: "plus")
                }
            }
        }
        .padding(15)
    }
}
