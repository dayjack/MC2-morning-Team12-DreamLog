//
//  ButtonWhiteBoldModifier.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

struct ButtonWhiteBoldModifier: ViewModifier {
    
    var isActive: Bool = true
    
    func body(content: Content) -> some View {
        content
            .background(.white)
            .font(.custom("Apple SD Gothic Neo", size: 24))
            .fontWeight(.bold)
            .foregroundColor(.activeBrown)
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
            }
            .foregroundColor(.activeBrown)
            .padding(.bottom, 20)
            
    }
}
