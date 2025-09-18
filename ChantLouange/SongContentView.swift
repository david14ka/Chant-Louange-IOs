//
//  ContentView.swift
//  ccantiques
//
//  Created by DAVID KAZAD on 9/9/25.
//

import SwiftUI


struct SongDetailView: View {
    let book: Book
    let song: Song

    var body: some View {
        ScrollView {
            
            VStack(alignment: .center, spacing: 1) {

                //Different pare using, 7 equal to Only believe book that contains specials markdown
                if(book.id == 7 ) {
                    parseMarkdownLike(song.content)
                        .reduce(Text(""), +) // Combine array of Text into a single Text
                        .font(.system(size: 22)) // increase font size
                                .lineSpacing(4)
                } else {
                    song.content.splitSpecialBlocks().reduce(Text(""), +)
                        .font(.system(size: 22)) // increase font size
                                .lineSpacing(4)
                }
            }
            .padding()
            
        }
        .scrollIndicators(.hidden)
        .navigationTitle("N° \(song.number)")
        .background(BgImageGradient())
    }
}

