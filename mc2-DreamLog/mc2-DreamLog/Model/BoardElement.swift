//
//  BoardElement.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

struct BoardElement: Identifiable, Hashable {
    
    let id = UUID()
    
    var offsetX: CGFloat = 0
    var offsetY: CGFloat = 0

    var elementAngle = 0
    
    var elmentScale = 1
    
    var elementView: Image
    
    init(offsetX: CGFloat = 0, offsetY: CGFloat = 0, elementAngle: Int = 0, elmentScale: Int = 1, elementView: Image) {
        self.offsetX = offsetX
        self.offsetY = offsetY
        self.elementAngle = elementAngle
        self.elmentScale = elmentScale
        self.elementView = elementView
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
