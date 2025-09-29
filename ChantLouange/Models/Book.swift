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
    var songs: [Song]
    var bookComingSoon: Bool = true
    let id: Int
    
    static public func emptyBookData() -> Book{
        return Book(title: "Other books", author: "Other_books", songs: [], id: 0)
    }
}
