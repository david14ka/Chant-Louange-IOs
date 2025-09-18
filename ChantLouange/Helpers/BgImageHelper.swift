//
//  BackgoundImageGradient.swift
//  ChantLouange
//
//  Created by DAVID KAZAD on 9/18/25.
//

import SwiftUI

struct BgImageGradient : View {
    var image: String = "bg"
    
    var body: some View {
        return ZStack {
            Image(image)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.6), // dark bottom
                    Color.clear              // fade to transparent
                ]),
                startPoint: .bottom,
                endPoint: .top
            )
            .ignoresSafeArea()
        }
    }
}
