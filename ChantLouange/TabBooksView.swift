//
//  TabBooksView.swift
//  ccantiques
//
//  Created by DAVID KAZAD on 9/22/25.
//

import SwiftUI

struct TabBooksView: View {
    @ObservedObject var bookData: BookData
    
    var body: some View {
        BookListView(bookData: bookData)
    }
}

#Preview {
    
    TabBooksView(bookData: BookDataPreview(books: sampleBooks))
}
