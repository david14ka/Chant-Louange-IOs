//
//  Helper.swift
//  ccantiques
//
//  Created by DAVID KAZAD on 9/16/25.
//

import SwiftUI

// MARK: - Helper function to parse Markdown-like text
/// Returns a single SwiftUI Text view with inline bold, italic, and bold+italic
  /// Supports:
  /// - ***bold italic***
  /// - **bold**
  /// - *italic*
func parseStyledText(_ content: String) -> Text {
    var result: Text = Text("")
    var remaining = content[...]
    
    while !remaining.isEmpty {
        // Check for bold+italic (***text***)
        if let range = remaining.range(of: "***") {
            let before = remaining[..<range.lowerBound]
            if !before.isEmpty {
                result = result + Text(String(before))
            }
            remaining = remaining[range.upperBound...]
            if let endRange = remaining.range(of: "***") {
                let boldItalicText = remaining[..<endRange.lowerBound]
                result = result + Text(String(boldItalicText)).bold().italic()
                remaining = remaining[endRange.upperBound...]
            } else {
                result = result + Text(String(remaining))
                break
            }
        }
        // Check for bold (**text**)
        else if let range = remaining.range(of: "**") {
            let before = remaining[..<range.lowerBound]
            if !before.isEmpty {
                result = result + Text(String(before))
            }
            remaining = remaining[range.upperBound...]
            if let endRange = remaining.range(of: "**") {
                let boldText = remaining[..<endRange.lowerBound]
                result = result + Text(String(boldText)).bold()
                remaining = remaining[endRange.upperBound...]
            } else {
                result = result + Text(String(remaining))
                break
            }
        }
        // Check for italic (*text*)
        else if let range = remaining.range(of: "*") {
            let before = remaining[..<range.lowerBound]
            if !before.isEmpty {
                result = result + Text(String(before))
            }
            remaining = remaining[range.upperBound...]
            if let endRange = remaining.range(of: "*") {
                let italicText = remaining[..<endRange.lowerBound]
                result = result + Text(String(italicText)).italic()
                remaining = remaining[endRange.upperBound...]
            } else {
                result = result + Text(String(remaining))
                break
            }
        }
        // No markers left
        else {
            result = result + Text(String(remaining))
            break
        }
    }
    
    return result
}

/// Returns a SwiftUI Text view with inline bold, italic, and color support
    /// Markers:
    /// - ***bold italic***
    /// - **bold**
    /// - *italic*
    /// - {color:red}colored text{/color}

func parseMarkdownLike(_ content: String) -> [Text] {
    var result: [Text] = []
    var remaining = content[...]
    
    while let startRange = remaining.range(of: "*") {
        // Text before bold
        let before = remaining[..<startRange.lowerBound]
        if !before.isEmpty {
            result.append(Text(String(before)))
        }
        
        // Look for closing *
        remaining = remaining[startRange.upperBound...]
        if let endRange = remaining.range(of: "*") {
            let boldText = remaining[..<endRange.lowerBound]
            result.append(Text(String(boldText)).bold().italic().foregroundColor(Color(.indigo)))
            
            remaining = remaining[endRange.upperBound...]
        } else {
            // No closing **, just treat rest as normal
            result.append(Text(String(remaining)))
            break
        }
    }
    
    // Any remaining text
    if !remaining.isEmpty {
        result.append(Text(String(remaining)))
    }
    
    return result
}


extension String {
    
    /// Returns a SwiftUI Text view with:
    /// - ***bold italic***
    /// - **bold**
    /// - *italic*
    /// - Color applied to any detected range
    /// - Multiple styles in one line
    func styledText(coloredRange: Range<String.Index>? = nil, color: Color = .red) -> Text {
        var result: Text = Text("")
        var remaining = self[...]

        while !remaining.isEmpty {
            // Bold + Italic: ***text***
            if let range = remaining.range(of: "***") {
                let before = remaining[..<range.lowerBound]
                if !before.isEmpty { result = result + Text(String(before)) }

                remaining = remaining[range.upperBound...]
                if let endRange = remaining.range(of: "***") {
                    var boldItalicText = Text(String(remaining[..<endRange.lowerBound])).bold().italic()
                    
                    // Apply color if this range overlaps
                    if let r = coloredRange {
                        let start = self.distance(from: self.startIndex, to: remaining.startIndex)
                        let end = self.distance(from: self.startIndex, to: endRange.lowerBound)
                        if start < self.distance(from: self.startIndex, to: r.upperBound) &&
                            end > self.distance(from: self.startIndex, to: r.lowerBound) {
                            boldItalicText = boldItalicText.foregroundColor(color)
                        }
                    }
                    
                    result = result + boldItalicText
                    remaining = remaining[endRange.upperBound...]
                } else {
                    result = result + Text(String(remaining))
                    break
                }
            }
            
            // Bold: **text**
            else if let range = remaining.range(of: "**") {
                let before = remaining[..<range.lowerBound]
                if !before.isEmpty { result = result + Text(String(before)) }

                remaining = remaining[range.upperBound...]
                if let endRange = remaining.range(of: "**") {
                    var boldText = Text(String(remaining[..<endRange.lowerBound])).bold()
                    
                    if let r = coloredRange {
                        let start = self.distance(from: self.startIndex, to: remaining.startIndex)
                        let end = self.distance(from: self.startIndex, to: endRange.lowerBound)
                        if start < self.distance(from: self.startIndex, to: r.upperBound) &&
                            end > self.distance(from: self.startIndex, to: r.lowerBound) {
                            boldText = boldText.foregroundColor(color)
                        }
                    }
                    
                    result = result + boldText
                    remaining = remaining[endRange.upperBound...]
                } else {
                    result = result + Text(String(remaining))
                    break
                }
            }
            
            // Italic: *text*
            else if let range = remaining.range(of: "*") {
                let before = remaining[..<range.lowerBound]
                if !before.isEmpty { result = result + Text(String(before)) }

                remaining = remaining[range.upperBound...]
                if let endRange = remaining.range(of: "*") {
                    var italicText = Text(String(remaining[..<endRange.lowerBound])).italic()
                    
                    if let r = coloredRange {
                        let start = self.distance(from: self.startIndex, to: remaining.startIndex)
                        let end = self.distance(from: self.startIndex, to: endRange.lowerBound)
                        if start < self.distance(from: self.startIndex, to: r.upperBound) &&
                            end > self.distance(from: self.startIndex, to: r.lowerBound) {
                            italicText = italicText.foregroundColor(color)
                        }
                    }
                    
                    result = result + italicText
                    remaining = remaining[endRange.upperBound...]
                } else {
                    result = result + Text(String(remaining))
                    break
                }
            }
            
            // No markers left
            else {
                var normalText = Text(String(remaining))
                if let r = coloredRange {
                    let start = self.distance(from: self.startIndex, to: remaining.startIndex)
                    let end = self.distance(from: self.startIndex, to: self.endIndex)
                    if start < self.distance(from: self.startIndex, to: r.upperBound) &&
                        end > self.distance(from: self.startIndex, to: r.lowerBound) {
                        normalText = normalText.foregroundColor(color)
                    }
                }
                result = result + normalText
                break
            }
        }
        
        return result
        // Mark : Usage Example
//        let songTitle = "**1** *Amazing Grace*"
//        let rangeToColor = songTitle.range(of: "Amazing Grace") // apply red to title
//        Text(songTitle.styledText(coloredRange: rangeToColor, color: .red))
//            .lineLimit(1)
//            .truncationMode(.tail)
    }

    // MARK: - Helper function to parse  Markdown-like \n\n using in CC CV...
    
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
                    result.append(Text(normalText))
                }
                
                // Add matched block with custom style
                let blockText = String(self[range])
                result.append(Text(blockText).foregroundColor(.indigo).italic())
                
                lastIndex = range.upperBound
            }
            
            // Add remaining text
            if lastIndex < self.endIndex {
                let remaining = String(self[lastIndex..<self.endIndex])
                result.append(Text(remaining))
            }
            
        } catch {
            result.append(Text(self))
        }
        
        return result
    }
    
}
