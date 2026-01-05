//
//  CreateNoteView.swift
//  til
//
//  Created by Кирилл Гусев on 04.01.2026.
//

import SwiftUI
import Foundation

struct CreateNoteView: View {

    let viewModel: CreateNoteViewModel

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
                    Task {
                        do {
                            let success = try await viewModel.createNote(date: date, body: text)
                            success ? dismissWindow(id: "note") : print("Error with closing window!")
                        } catch {
                            print("Error with creating note after tap: \(error)")
                        }
                    }
                } label: {
                    Label("Add", systemImage: "plus")
                }
            }
        }
        .padding(15)
    }
}
