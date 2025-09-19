//
//  Models.swift
//  ccantiques
//
//  Created by DAVID KAZAD on 9/9/25.
//

import Foundation

struct Song: Identifiable, Codable {
    let title: String
    let number: String
    let content: String
    var id: UUID { UUID() } // For SwiftUI Identifiable
}

