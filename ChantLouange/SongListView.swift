//
//  SongListView.swift
//  ccantiques
//
//  Created by DAVID KAZAD on 9/16/25.
//
import SwiftUI

struct SongListView: View {
    let book: Book
    @State private var searchText = ""

    var filteredSongs: [Song] {
        if searchText.isEmpty {
            return book.songs
        } else {
            return book.songs.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.number.localizedCaseInsensitiveContains(searchText) ||
                $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        ZStack {
            // Background image + gradient overlay
            // Optimized List
            List {
                ForEach(filteredSongs) { song in
                    NavigationLink(destination: SongDetailView(book: book, song: song)) {
                        HStack {
                            Text("\(song.number)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)
                                .frame(width: 40, alignment: .leading)

                            Text(song.title)
                                .font(.body)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .foregroundColor(.white)

                            Spacer()
                        }
                    }
                    
                    .listRowBackground(Color.clear) // Makes row background transparent
                }
            }
            
            .scrollContentBackground(.hidden) // Hides default List background
        }
        .background(BgImageGradient())
        .navigationTitle(book.title)
        .searchable(text: $searchText, prompt: "Search songs")
    
    }
}

struct SongListViewWhiteList: View {
    let book: Book
    @State private var searchText = ""

    var filteredSongs: [Song] {
        if searchText.isEmpty {
            return book.songs
        } else {
            return book.songs.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.number.localizedCaseInsensitiveContains(searchText) ||
                $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        ZStack {
            
            // The list itself
            List(filteredSongs) { song in
                NavigationLink(destination: SongDetailView(book: book, song: song)) {
                    HStack {
                        // Song number
                        Text("\(song.number)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                        
                        // Song title (1 line only)
                        Text(song.title)
                            .font(.body)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .foregroundColor(.primary)
                    }
                }
            }
            //.scrollContentBackground(.hidden)
        }.background(BgImageGradient())
        
        .navigationTitle(book.title).truncationMode(.tail)
//        .navigationTitle(book.title.count > 20
//                         ? String(book.title.prefix(15)) + "…"
//                         : book.title)
        .searchable(text: $searchText, prompt: "Search songs")
        
    }
}
