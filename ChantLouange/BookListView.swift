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
            
            ZStack() {
                // Background image
                // Gradient overlay
                
                VStack{
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(bookData.books) { book in
                                
                                if(!book.bookComingSoon){
                                    
                                    NavigationLink(destination: SongListView(book: book)) {
                                        BookCardView(book: book)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            //More books option to view other books not include in main page
                            NavigationLink(destination: MoreBookListViewSimple(bookData: bookData)) {
                                BookCardView(book: Book.emptyBookData(), cardAlignment: .center)
                            }
                            .buttonStyle(.plain)
                            
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 20)
                    }
                    .background(BgImageGradient())
                    
                }
                
            }
            .navigationTitle("Books")
        }
    }
}

struct BookCardView: View {
    let book: Book
    var cardAlignment: Alignment = .bottom
    
    var body: some View {
        ZStack(alignment: cardAlignment) {
            // Background image
            Image(book.author.replacingOccurrences(of: " ", with: ""))
                .resizable()
                .scaledToFill()
                .frame(width: 160, height: 180)
                .clipped()
                .cornerRadius(16)
            
            // Gradient overlay for readability
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(1), Color.clear]),
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
        .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white, lineWidth: 1)
                )
    }
}

// not used
struct MoreBookListViewSimple: View {
    @ObservedObject var bookData: BookData

    var body: some View {
        NavigationStack {
            ZStack{
                List(bookData.books) { book in
                    
                    if(book.bookComingSoon){
                        NavigationLink(book.title) {
                            SongListView(book: book)
                        }
                    }
                    
                }.textCase(.uppercase)
                .scrollContentBackground(.hidden) // Hides default List background
            }
            .background(BgImageGradient())
            .navigationTitle("More Books")
        }
    }
}

// MARK: - Previews
struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView(bookData: BookDataPreview(books: sampleBooks))
    }
}



