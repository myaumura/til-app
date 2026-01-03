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

struct ContentView: View {
    
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        NavigationSplitView {
            List {
                Text("Learned")
                Text("Todo")
            }
        } detail: {
            Text("Content")
                .navigationTitle("Content View")
        }
        .toolbar {
            Button("", systemImage: "plus") {
                openWindow(id: "note")
            }
        }
    }
}

#Preview {
    ContentView()
}
