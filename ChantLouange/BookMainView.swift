//
//  MainView.swift
//  ChantLouange
//
//  Created by DAVID KAZAD on 9/19/25.
//

import SwiftUI

struct BookMainView: View {
    
    @ObservedObject var bookData: BookData
    @StateObject var favoriteManager = FavoriteManager()

    var body: some View {
        
        TabView {
            TabBooksView(bookData: bookData) // ✅ Pass instance, not type
                .environmentObject(favoriteManager)
                .tabItem {
                    Image(systemName: "music.note.list")
                    Text("Books")
                }

            TabFavoritesView()
                .environmentObject(favoriteManager)
                .environmentObject(bookData)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }

            TabInfoView()
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Info")
                }
        }
        .background(BgImageGradient())   // Background for whole TabView
        .accentColor(.red)            // Selected tab tint
    }
}


// Dummy data for preview


#Preview {
    BookMainView(bookData: BookDataPreview(books: sampleBooks))
}

