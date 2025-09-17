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
    var booksResourceUrl : [String] = ["CC", "CV","NM","NW","OB","NP","NB"]
    
    init() {
        loadAllBooks()
    }

    func loadAllBooks() {
        DispatchQueue.global(qos: .background).async {
            var loadedBooks: [Book] = []
            

            for i in 0...self.booksResourceUrl.count-1 { // assuming 5 books
                if let url = Bundle.main.url(forResource: self.booksResourceUrl[i].uppercased(), withExtension: "json") {
                    do {
                        let data = try Data(contentsOf: url)
                        let book = try JSONDecoder().decode(Book.self, from: data)
                        loadedBooks.append(book)
                    } catch {
                        print("Error loading Book \(self.booksResourceUrl[i]).json: \(error)")
                    }
                } else {
                    print("Book \(self.booksResourceUrl[i]).json not found")
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
