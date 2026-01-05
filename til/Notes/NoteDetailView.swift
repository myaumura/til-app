//
//  NoteView.swift
//  til
//
//  Created by Кирилл Гусев on 05.01.2026.
//

import SwiftUI

struct NoteDetailView: View {

    let viewModel: NoteDetailViewModel

    var body: some View {
        Text(viewModel.renderText())
    }
}

