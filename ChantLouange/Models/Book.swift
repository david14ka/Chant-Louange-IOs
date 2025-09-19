//
//  Models.swift
//  ccantiques
//
//  Created by DAVID KAZAD on 9/9/25.
//

import Foundation

struct Book: Identifiable, Codable {
    let title: String
    let author: String
    //var abbreviation : String
    let songs: [Song]
    let id: Int
    //var id: UUID { UUID() }
}
