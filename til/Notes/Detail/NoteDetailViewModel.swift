//
//  NoteDetailViewModel.swift
//  til
//
//  Created by Кирилл Гусев on 05.01.2026.
//

import Foundation
import PathKit

@Observable
final class NoteDetailViewModel {

    let note: Note

    init(note: Note) {
        self.note = note
    }

    func renderText() -> AttributedString {
        var text = AttributedString("")

        do {
            let path = Path(note.file)

            text = try AttributedString(contentsOf: path.url)
        } catch {
            print("Error with rendering markdown!")
        }

        return text
    }
}
