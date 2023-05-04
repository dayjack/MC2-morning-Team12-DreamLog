//
//  TextBrownModifier.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

struct TextBrownModifier: ViewModifier {
    
    var fontSize: CGFloat = 22
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Apple SD Gothic Neo", size: fontSize))
            .foregroundColor(.textBrown)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .lineSpacing(7)
            .lineLimit(3)
    }
}

