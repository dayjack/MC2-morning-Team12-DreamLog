//
//  MenuButtonModifier.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/08.
//

import SwiftUI

struct MenuButtonModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
//            .foregroundColor(.secondary)
            .padding(15)
            .background(.white)
            .clipShape(Circle())
            .shadow(radius: 2)
    }
}
