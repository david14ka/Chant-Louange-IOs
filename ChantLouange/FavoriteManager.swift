//
//  FavoriteManager.swift
//  ccantiques
//
//  Created by DAVID KAZAD on 9/22/25.
//

import Foundation
import SwiftUI

final class FavoriteManager: ObservableObject {
    @Published private(set) var favorites: Set<String> = []
    private let storageKey = "favoriteSongs"

    init() {
        loadFavorites()
    }

    private func idString(for song: Song, of book: Book) -> String {
        //let id =
        String(describing: (book.id * 100000 + song.id)) // works for UUID, Int, String, etc.
    }

    func isFavorite(book: Book, song: Song) -> Bool {
        
        favorites.contains(idString(for: song, of: book))
    }

    func toggle(book: Book, song: Song) {
        let id = idString(for: song, of: book)
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
        print("Toggle \(id)")
        saveFavorites()
    }

    private func loadFavorites() {
        if let saved = UserDefaults.standard.array(forKey: storageKey) as? [String] {
            favorites = Set(saved)
        }
    }

    private func saveFavorites() {
        UserDefaults.standard.set(Array(favorites), forKey: storageKey)
    }
    
     func toggleFavorite(book: Book, song: Song) {
        let key = book.id * 100000 + song.id
        if favorites.contains(String(describing: (key))) {
            favorites.remove(String(describing: (key)))
            print("Removed favorite: book \(book.id), song \(song.id), key \(key)")
        } else {
            favorites.insert(String(describing: (key)))
            print("Added favorite: book \(book.id), song \(song.id), key \(key)")
        }
         saveFavorites()
    }
}
