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
