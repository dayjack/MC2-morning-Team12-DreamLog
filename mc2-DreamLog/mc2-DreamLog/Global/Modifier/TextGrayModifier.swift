//
//  TextGrayModifier.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

struct TextGrayModifier: ViewModifier {
    
    var fontSize: CGFloat = 18
    
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .foregroundColor(.textGray)
            .padding(.bottom, 16)
            .lineSpacing(7)
    }
}
