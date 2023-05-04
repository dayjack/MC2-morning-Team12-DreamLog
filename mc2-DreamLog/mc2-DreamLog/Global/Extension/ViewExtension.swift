//
//  ViewExtension.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

extension View {
    
    func brownText(fontSize: CGFloat = 22) -> some View {
        modifier(TextBrownModifier(fontSize: fontSize))
    }
    
    func brownButton(isActive: Bool = true) -> some View {
        modifier(ButtonBrownModifier(isActive: isActive))
    }
    func whiteWithBorderButton() -> some View {
        modifier(ButtonWhiteBoldModifier())
    }
    
    func grayText(fontSize: CGFloat = 18) -> some View {
        modifier(TextGrayModifier(fontSize: fontSize))
    }
}

