//
//  Helper.swift
//  ccantiques
//
//  Created by DAVID KAZAD on 9/16/25.
//

//import SwiftUI
//
//func parseMarkdownLike(_ content: String) -> [Text] {
//    var result: [Text] = []
//    var remaining = content[...]
//    
//    while let startRange = remaining.range(of: "*") {
//        // Text before bold
//        let before = remaining[..<startRange.lowerBound]
//        if !before.isEmpty {
//            result.append(Text(String(before)).foregroundColor(Color(.white)))
//        }
//        
//        // Look for closing *
//        remaining = remaining[startRange.upperBound...]
//        if let endRange = remaining.range(of: "*") {
//            let boldText = remaining[..<endRange.lowerBound]
//            result.append(Text(String(boldText))
//                .bold()
//                .italic()
//                .foregroundColor(Color("SongContentColor")))
//            
//            remaining = remaining[endRange.upperBound...]
//        } else {
//            // No closing **, just treat rest as normal
//            result.append(Text(String(remaining)).foregroundColor(Color(.white)))
//            break
//        }
//    }
//    
//    // Any remaining text
//    if !remaining.isEmpty {
//        result.append(Text(String(remaining)))
//    }
//    
//    return result
//}
//
//
//extension String {
//   
//
//    // MARK: - Helper function to parse  Markdown-like \n\n using in CC CV...
//    
//    func splitSpecialBlocks() -> [Text] {
//        var result: [Text] = []
//        let pattern = #"(?<=\n\n)(?!\d)(.*?)(?=\n\n\d)"#
//        
//        do {
//            let regex = try NSRegularExpression(pattern: pattern, options: [.dotMatchesLineSeparators])
//            let nsrange = NSRange(self.startIndex..<self.endIndex, in: self)
//            var lastIndex = self.startIndex
//            
//            regex.enumerateMatches(in: self, options: [], range: nsrange) { match, _, _ in
//                guard let match = match, let range = Range(match.range, in: self) else { return }
//                
//                // Add text before match as normal
//                if lastIndex < range.lowerBound {
//                    let normalText = String(self[lastIndex..<range.lowerBound])
//                    result.append(Text(normalText).foregroundColor(Color(.white)))
//                }
//                
//                // Add matched block with custom style
//                let blockText = String(self[range])
//                result.append(Text(blockText)
//                    .foregroundColor(Color("SongContentColor"))
//                    .italic()
//                    .bold())
//            
//                
//                lastIndex = range.upperBound
//            }
//            
//            // Add remaining text
//            if lastIndex < self.endIndex {
//                let remaining = String(self[lastIndex..<self.endIndex])
//                result.append(Text(remaining).foregroundColor(Color(.white)))
//            }
//            
//        } catch {
//            result.append(Text(self))
//        }
//        
//        return result
//    }
//    
//}
//
//



import SwiftUI

extension String {
    
    /// Parse *bold* markers in a Markdown-like style
    func parseMarkdownLike() -> [Text] {
        var result: [Text] = []
        var remaining = self[...]
        
        while let startRange = remaining.range(of: "*") {
            // Text before bold
            let before = remaining[..<startRange.lowerBound]
            if !before.isEmpty {
                result.append(Text(String(before)).defaultStyle())
            }
            
            // Look for closing *
            remaining = remaining[startRange.upperBound...]
            if let endRange = remaining.range(of: "*") {
                let boldText = remaining[..<endRange.lowerBound]
                result.append(
                    Text(String(boldText))
                        .bold()
                        .italic()
                        .foregroundColor(Color("SongContentColor"))
                )
                
                remaining = remaining[endRange.upperBound...]
            } else {
                // No closing *, just treat rest as normal
                result.append(Text(String(remaining)).defaultStyle())
                break
            }
        }
        
        // Any remaining text
        if !remaining.isEmpty {
            result.append(Text(String(remaining)).defaultStyle())
        }
        
        return result
    }
    
    
    /// Parse blocks between \n\n and numbers with custom styling
    func splitSpecialBlocks() -> [Text] {
        var result: [Text] = []
        let pattern = #"(?<=\n\n)(?!\d)(.*?)(?=\n\n\d)"#
        
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [.dotMatchesLineSeparators])
            let nsrange = NSRange(self.startIndex..<self.endIndex, in: self)
            var lastIndex = self.startIndex
            
            regex.enumerateMatches(in: self, options: [], range: nsrange) { match, _, _ in
                guard let match = match, let range = Range(match.range, in: self) else { return }
                
                // Add text before match as normal
                if lastIndex < range.lowerBound {
                    let normalText = String(self[lastIndex..<range.lowerBound])
                    result.append(Text(normalText).defaultStyle())
                }
                
                // Add matched block with custom style
                let blockText = String(self[range])
                result.append(
                    Text(blockText)
                        .bold()
                        .italic()
                        .foregroundColor(Color("SongContentColor"))
                )
                
                lastIndex = range.upperBound
            }
            
            // Add remaining text
            if lastIndex < self.endIndex {
                let remaining = String(self[lastIndex..<self.endIndex])
                result.append(Text(remaining).defaultStyle())
            }
            
        } catch {
            result.append(Text(self).defaultStyle())
        }
        
        return result
    }
}

extension Text {
    /// Default style applied everywhere
    func defaultStyle() -> Text {
        self.foregroundColor(.white)
    }
}


