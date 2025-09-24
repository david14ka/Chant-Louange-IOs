//
//  ccantiquesApp.swift
//  ccantiques
//
//  Created by DAVID KAZAD on 9/9/25.
//

import SwiftUI
import UIKit
import CoreImage

// MARK: - App Entry

@main
struct ChantLouangeBookApp: App {
    
   
    init() {
        var avgColor: UIColor = .black
        if let bgImage = UIImage(named: "bg"),
           let blended = bgImage.withGradientOverlay(colors: [
            UIColor.black.withAlphaComponent(0.5),
            UIColor.clear
           ]),
           let color = blended.averageColor(topPercent: 0.15) {
            avgColor = color
        }
        
        // Clear (transparent) appearance for top edge (before scroll)
        let clearAppearance = UINavigationBarAppearance()
        clearAppearance.configureWithTransparentBackground()
        clearAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        clearAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Colored appearance for scrolled state
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = avgColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Apply globally
        UINavigationBar.appearance().tintColor = .systemIndigo
        UINavigationBar.appearance().standardAppearance = coloredAppearance   // When scrolled
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = clearAppearance   // At top, before scroll
        
        
        //Tab
        
        // Customize tab bar globally
                let appearance = UITabBarAppearance()
                appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = avgColor.withAlphaComponent(0.4)//UIColor.black.withAlphaComponent(0.4) // dark background

                // Normal state (unselected) → white
                let normalAttributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.white
                ]
                appearance.stackedLayoutAppearance.normal.iconColor = .white
                appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes

                // Selected state → red
                let selectedAttributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.red
                ]
                appearance.stackedLayoutAppearance.selected.iconColor = .red
                appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes

                // Apply appearance
                UITabBar.appearance().standardAppearance = appearance
                if #available(iOS 15.0, *) {
                    UITabBar.appearance().scrollEdgeAppearance = appearance
                }
        
    }
    @StateObject private var bookData = BookData()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
            //BookListView(bookData: bookData)
        }
    }
}

extension UIImage {
    
    /// Apply vertical gradient overlay
    func withGradientOverlay(colors: [UIColor]) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // Draw original image
        draw(in: CGRect(origin: .zero, size: size))
        
        // Create gradient
        let cgColors = colors.map { $0.cgColor } as CFArray
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                        colors: cgColors,
                                        locations: nil) else { return nil }
        
        context.drawLinearGradient(
            gradient,
            start: CGPoint(x: 0, y: 0),
            end: CGPoint(x: 0, y: size.height),
            options: []
        )
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    /// Get the average color of the top portion of the image
    func averageColor(topPercent: CGFloat = 0.15) -> UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        
        let width = inputImage.extent.width
        let height = inputImage.extent.height * topPercent
        let topRect = CGRect(x: 0, y: inputImage.extent.height - height, width: width, height: height)
        
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        
        guard let filter = CIFilter(name: "CIAreaAverage",
                                    parameters: [
                                        kCIInputImageKey: inputImage,
                                        kCIInputExtentKey: CIVector(cgRect: topRect)
                                    ]) else { return nil }
        
        guard let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: nil)
        
        return UIColor(
            red: CGFloat(bitmap[0]) / 255.0,
            green: CGFloat(bitmap[1]) / 255.0,
            blue: CGFloat(bitmap[2]) / 255.0,
            alpha: 1.0
        )
    }
}
