//
//  ButtonBrownModifier.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

struct ButtonBrownModifier: ViewModifier {
    
    var isActive: Bool = true
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Apple SD Gothic Neo", size: 24))
            .fontWeight(.bold)
            .background(isActive ? Color.activeBrown : Color.inactiveBrown )
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.bottom, 20)
    }
}
