//
//  ccantiquesApp.swift
//  ccantiques
//
//  Created by DAVID KAZAD on 9/9/25.
//

import SwiftUI

// MARK: - App Entry

@main
struct ccantiquesApp: App {

    @StateObject private var bookData = BookData()

        var body: some Scene {
            WindowGroup {
                //SplashScreenView()
                //BookListView(bookData: bookData)
            }
        }
}

