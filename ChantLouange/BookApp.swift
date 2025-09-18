//
//  ccantiquesApp.swift
//  ccantiques
//
//  Created by DAVID KAZAD on 9/9/25.
//

import SwiftUI

// MARK: - App Entry

@main
struct ChantLouangeBookApp: App {

    init() {
        // Transparent nav bar (when scrolling, background visible)
        let transparent = UINavigationBarAppearance()
        transparent.configureWithTransparentBackground()
        transparent.backgroundColor = .clear
        transparent.titleTextAttributes = [.foregroundColor: UIColor.black]
        transparent.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        // Flat tinted nav bar (when scrolled to top)
        let tinted = UINavigationBarAppearance()
        tinted.configureWithOpaqueBackground()
        tinted.backgroundColor = UIColor.black.withAlphaComponent(0.6) // subtle black tint
        // Or red tint:
        // tinted.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        tinted.titleTextAttributes = [.foregroundColor: UIColor.white]
        tinted.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Apply globally
        UINavigationBar.appearance().standardAppearance = tinted
        UINavigationBar.appearance().compactAppearance = tinted
        UINavigationBar.appearance().scrollEdgeAppearance = transparent
        
        // Global NavigationBar customization
               let appearance = UINavigationBarAppearance()
               appearance.configureWithTransparentBackground()
               appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
               appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
               
               UINavigationBar.appearance().tintColor = UIColor.systemIndigo   // Global back button color
               UINavigationBar.appearance().standardAppearance = appearance
               UINavigationBar.appearance().scrollEdgeAppearance = appearance
           
    }
    
    @StateObject private var bookData = BookData()

        var body: some Scene {
            WindowGroup {
                SplashScreenView()
                //BookListView(bookData: bookData)
            }
        }
}

