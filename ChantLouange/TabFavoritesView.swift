//
//  TabFavoritesView.swift
//  ccantiques
//
//  Created by DAVID KAZAD on 9/22/25.
//

import SwiftUI

struct TabFavoritesView: View {
    @EnvironmentObject var favoriteManager: FavoriteManager
    @EnvironmentObject var bookData: BookData
    
    // flat list of songs that are favorited
    var favoriteSongs0: [Song] {
        bookData.books
            .flatMap { $0.songs }
            .filter { favoriteManager.favorites.contains(String(describing: $0.id)) }
    }
    // Flat list of songs that are favorited
    var favoriteSongs: [Song] {
        bookData.books.flatMap { book in
            book.songs.filter { song in
                let key = book.id * 100000 + song.id
                let contains = favoriteManager.favorites.contains(String(describing:(key)))
                if contains {
                    print("Matched favorite: book \(book.id), song \(song.id), key \(key)")
                }
                return contains
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(bookData.books) { book in
                    
                    let favSongs = book.songs.filter { song in
                        let key = book.id * 100000 + song.id
                        return favoriteManager.favorites.contains(String(describing:(key)))
                    }
                    if !favSongs.isEmpty {
                        Section(header: Text(book.title).foregroundColor(.red)) {
                            
                            ForEach(favSongs) { song in
                                NavigationLink(destination: SongDetailView(book: book, song: song)) {
                                    HStack {
                                        // Song number
                                        Text("\(song.number)")
                                            .font(.subheadline)
                                            //.fontWeight(.thin)
                                            .foregroundColor(.white)
                                        
                                        // Song title (1 line only)
                                        Text(song.title)
                                            //.font(.subheadline)
                                            .lineLimit(1)
                                            //.fontWeight(.thin)
                                            .truncationMode(.tail)
                                            .foregroundColor(.white)
                                        
                                        Spacer()
                                    }
                                    
                                }
                                .listRowBackground(Color.clear) // Makes row background transparent
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden) // Hides default List background
            }.padding(.bottom)
            .scrollContentBackground(.hidden)
            .navigationTitle("Favorites songs")
            .background(BgImageGradient())
        }
    }
}


#Preview {
    TabFavoritesView()
}
