//
//  Note.swift
//  til
//
//  Created by Кирилл Гусев on 03.01.2026.
//

import Foundation
import SQLiteData

@Table
struct Note: Codable, Hashable {
    let id: UUID
    let date: String
    let file: String
}
