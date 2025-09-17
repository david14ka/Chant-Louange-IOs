//
//  ContentView.swift
//  ccantiques
//
//  Created by DAVID KAZAD on 9/11/25.
//

import SwiftUI


struct BookListView: View {
    @ObservedObject var bookData: BookData

    // Adaptive grid layout
    let columns = [
        GridItem(.adaptive(minimum: 160), spacing: 20) // Card minimum width
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(bookData.books) { book in
                        NavigationLink(destination: SongListView(book: book)) {
                            BookCardView(book: book)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Receuils")
        }
    }
}

struct BookCardView: View {
    let book: Book
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Background image (replace with actual images in Assets)
            Image(book.author.replacingOccurrences(of: " ", with: ""))
                .resizable()
                .scaledToFill()
                .frame(width: 160, height: 180)
                .clipped()
                .cornerRadius(16)
            
            // Gradient overlay for readability
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                startPoint: .bottom,
                endPoint: .top
            )
            .cornerRadius(16)
            
            // Title text
            Text(book.title)
                .font(.system(size: 20))
                .fontWeight(.bold)
                //.font(.headline)
                .fontWeight(.semibold)
                .lineLimit(2)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
            
            
        }
        .frame(width: 160, height: 180)
        .cornerRadius(16)
        .shadow(radius: 5)
    }
}

// not used
struct BookListViewSimple: View {
    @ObservedObject var bookData: BookData

    var body: some View {
        NavigationStack {
            List(bookData.books) { book in
                NavigationLink(book.title) {
                    SongListView(book: book)
                }
            }
            
            .navigationTitle("Receuils")
        }
    }
}

// MARK: - Previews
struct BookListView_Previews: PreviewProvider {
    static let sampleBooks = [
        Book(title: "Book One", author: "Author A", songs: [
            Song(title: "Song 1", number: "1", content: "Sample content 1"),
            Song(title: "Song 2", number: "2", content: "Sample content 2")
        ], id: 1),
        Book(title: "Book Two", author: "Author B", songs: [
            Song(title: "Song 1", number: "1", content: "Sample content 1"),
            Song(title: "Song 2", number: "2", content: "Sample content 2")
        ], id: 2)
    ]
    
    static var previews: some View {
        BookListView(bookData: BookDataPreview(books: sampleBooks))
    }
}



