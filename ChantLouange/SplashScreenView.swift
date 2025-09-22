//
//  Splash.swift
//  ChantLouange
//
//  Created by DAVID KAZAD on 9/17/25.
//


import SwiftUI


struct SplashScreenView: View {
    @State private var isActive = false
    @State private var opacity = 0.0
    
    var body: some View {
        if isActive {
            // Navigate to main content
            BookListView(bookData: BookData())
        } else {
            
            ZStack {
                
                // Background image
                BgImageGradient()
                
                VStack {
                    Image("bg")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle()) // round shape
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 3) // optional white border
                        )
                        .shadow(radius: 10) // soft shadow
                        .opacity(opacity)
                       
                    
                    Text("Chant & Louange")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .opacity(opacity)
                    Text("Pour des réunions d’évangélisation et d’édification")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.white)
                        .opacity(opacity)
                }
            
                
                .onAppear {
                    withAnimation(.easeIn(duration: 3.0)) {
                        opacity = 1.0
                    }
                    
                    // Delay before fade transition
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation(.easeInOut(duration: 3.0)) {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}
struct SplashView_Previews: PreviewProvider {

    static var previews: some View {
        SplashScreenView()
    }
}
