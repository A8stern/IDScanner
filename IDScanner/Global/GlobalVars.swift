//
//  Global.swift
//  IDScanner
//
//  Created by Kovalev Gleb on 27.09.2024.
//

import SwiftUI

var black: Color = Color(hex: 0x0B090A)
var blackLess: Color = Color(hex: 0x161A1D)
var redDark: Color = Color(hex: 0x660708)
var redDarkLess: Color = Color(hex: 0xA4161A)
var redBrightLess: Color = Color(hex: 0xBA181B)
var redBright: Color = Color(hex: 0xE5383B)
var grey: Color = Color(hex: 0xB1A7A6)
var greyLight: Color = Color(hex: 0xD3D3D3)
var whiteDark: Color = Color(hex: 0xF5F3F4)
var white: Color = Color(hex: 0xFFFFFF)

var greenApproval: Color = Color(hex: 0x22A742)
var redBad: Color = Color(hex: 0xA72324)
var blueText: Color = Color(hex: 0x102F4E)
var greyText: Color = Color(hex: 0x8798A5)
var greyTextOnboarding: Color = Color(hex: 0x8E8E93)
var greyIndicator: Color = Color(hex: 0xE9E9E9)

var blueButton: Color = Color(hex: 0x007AFF)

var redOpacityBackground: Color = Color(hex: 0x1F060A)
var greenOpacityBackground: Color = Color(hex: 0x0A1A0C)
var redOpacityText: Color = Color(hex: 0xFF3654)
var greenOpacityText: Color = Color(hex: 0x37FF65)

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0x00FF00) >> 8) / 255.0
        let blue = Double(hex & 0x0000FF) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}
