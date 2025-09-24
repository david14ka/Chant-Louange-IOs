//
//  TabInfoView.swift
//  ccantiques
//
//  Created by DAVID KAZAD on 9/22/25.
//

import SwiftUI


struct TabInfoView: View {
    
    var body: some View {
        NavigationStack {
            List {
                // App Information
                Section(header: Text("App Information")) {
                    HStack {
                        Image(systemName: "app.fill")
                            .foregroundColor(.red)
                        VStack(alignment: .leading) {
                            Text("Chant & Louange")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Version \(Bundle.main.versionNumber) (\(Bundle.main.buildNumber))")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                    }
                    Text("This app contains collections of Christian songs, organized by books, with powerful search and favorites features.")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding(.top, 4)
                }
                .foregroundColor(.white)
                .listRowBackground(Color.clear)
                
                // Developer / Team
                Section(header: Text("Developer").foregroundColor(.white)) {
                    Label("David Kazad & Prince Ntunka", systemImage: "person.2.fill").foregroundColor(.white)
                   
                    Link(destination: URL(string: "mailto:support@chantlouange.app")!) {
                        Label("Contact Support", systemImage: "envelope.fill")
                            
                    }
                }
        
                .listRowBackground(Color.clear)
                
                // Feedback ChantLouange2025@ Admin
                Section(header: Text("Feedback").foregroundColor(.white)) {
                    Link(destination: URL(string: "https://apps.apple.com/app/6752624021")!) {
                        Label("Rate this App", systemImage: "star.fill")
                            .foregroundColor(.blue)
                    }
                    Link(destination: URL(string: "mailto:feedback@chantlouange.app")!) {
                        Label("Send Feedback", systemImage: "bubble.left.and.bubble.right.fill")
                            .foregroundColor(.blue)
                    }
                }
            
                //.listRowBackground(Color.clear)
                
                Section(header: Text("Legal").foregroundColor(.white)) {
                    Link("Privacy Policy", destination: URL(string: "https://chantlouange.app/privacy")!)
                        .foregroundColor(.blue)
                    Link("Terms of Service", destination: URL(string: "https://chantlouange.app/terms")!)
                        .foregroundColor(.blue)
                }
               
                .listRowBackground(Color.clear)
            }
            .navigationTitle("Info")
            .scrollContentBackground(.hidden)
            .background(BgImageGradient())
            
        }
    }
}

#Preview {
    TabInfoView()
}
