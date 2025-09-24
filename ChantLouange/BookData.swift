//
//  BookData.swift
//  ccantiques
//
//  Created by DAVID KAZAD on 9/9/25.
//

import Foundation
import SwiftUI

class BookData: ObservableObject {
    @Published var books: [Book] = []
    var booksResourceUri : [String] = ["CC", "CV","NM","NW","NP","NB","OB"]
    //var otherBooksResourceUri : [String] = ["CC", "CV","NM","NW","NP","NB","OB"]
    
    init() {
        loadAllBooks()
    }

    func loadAllBooks() {
        DispatchQueue.global(qos: .background).async {
            var loadedBooks: [Book] = []
            

            for i in 0...self.booksResourceUri.count-1 { 
                if let url = Bundle.main.url(forResource: self.booksResourceUri[i].uppercased(), withExtension: "json") {
                    do {
                        let data = try Data(contentsOf: url)
                        var book = try JSONDecoder().decode(Book.self, from: data)
                        if (book.id == 7){
                            
                            book.songs = book.songs.enumerated().map { index, song in
                                var newSong = song
                                newSong.id = index + 1  // auto-increment IDs
                                return newSong
                            }
                        }
                        
                        loadedBooks.append(book)
                        
                    } catch {
                        print("Error loading Book \(self.booksResourceUri[i]).json: \(error)")
                    }
                } else {
                    print("Book \(self.booksResourceUri[i]).json not found")
                }
            }

            DispatchQueue.main.async {
                self.books = loadedBooks
            }
        }
    }
}



class BookDataPreview: BookData {
    init(books: [Book]) {
        super.init()
        self.books = books
    }
    override func loadAllBooks() { }
}


let sampleBooks = [
    Book(title: "Book One", author: "Author A", songs: [
        Song(title: "Song 1", number: "1", content: "Sample content 1", id: 0),
        Song(title: "Song 2", number: "2", content: "Sample content 2", id: 1)
    ], id: 1),
    Book(title: "Book Two", author: "Author B", songs: [
        Song(title: "Song 1", number: "1", content: "Sample content 1", id: 0),
        Song(title: "Song 2", number: "2", content: "Sample content 2", id: 1)
    ], id: 2)
]
