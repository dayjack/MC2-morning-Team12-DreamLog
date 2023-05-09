//
//  ColorExtension.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/03.
//

import SwiftUI

extension Color {
    
    // 비활성화 된 버튼 색깔
    static let inactiveBrown = Color(hex: "#EBD7BD")
    // 활성화 된 버튼, 로고 색깔
    static let activeBrown = Color(hex: "#A2845E")
    // 초록색 텍스트 색깔
    static let textGreen = Color(hex: "#26980A")
    // 갈색 텍스트 색깔
    static let textBrown = Color(hex: "#4F2E05")
    // 회색 텍스트 색깔
    static let textGray = Color(hex: "#757575")
    // 앱 배경 색깔
    static let bgColor = Color(hex: "#FFFBF6")
    
    /// Color Pallete
    static let redStrong = Color(hex: "E10000")
    static let redLight = Color(hex: "F68383")
    static let orangeStrong = Color(hex: "FF5C00")
    static let orangeLight = Color(hex: "FFAF82")
    static let yellowStrong = Color(hex: "FFCC00")
    static let yellowLight = Color(hex: "FFE477")
    static let yellowGreenStrong = Color(hex: "CCE600")
    static let yellowGreenLight = Color(hex: "E2F261")
    static let greenStrong = Color(hex: "66B300")
    static let greenLight = Color(hex: "A9E55A")
    static let deepGreenStrong = Color(hex: "229100")
    static let deepGreenLight = Color(hex: "ACE39A")
    static let mintStrong = Color(hex: "00CC99")
    static let mintLight = Color(hex: "98F0DA")
    static let skyBlueStrong = Color(hex: "00E0F3")
    static let skyBlueLight = Color(hex: "95EBF2")
    static let blueStrong = Color(hex: "0040B3")
    static let blueLight = Color(hex: "82AEFF")
    static let purpleStrong = Color(hex: "8200FF")
    static let purpleLight = Color(hex: "C4A3E3")
    
    
    
    
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
      }
}
