//
//  SwiftUIView.swift
//  TodoList
//
//  Created by Can Ciftcioglu on 19.02.2025.
//
import SwiftUI

extension Color {
    init(hex: String) {
        // 🔥 Eğer "#" varsa temizle
        let cleanedHex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        
        var int: UInt64 = 0
        Scanner(string: cleanedHex).scanHexInt64(&int)
        
        let r, g, b: UInt64
        switch cleanedHex.count {
        case 6: // RGB (Normal)
            (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0) // Varsayılan siyah
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255.0,
            green: Double(g) / 255.0,
            blue: Double(b) / 255.0,
            opacity: 1.0
        )
    }
}
