//
//  BoardElement.swift
//  mc2-DreamLog
//
//  Created by ChoiYujin on 2023/05/04.
//

import SwiftUI

struct BoardElement: Identifiable, Hashable {
    
    let id = UUID()
    
    // 위치 : offset 용
    var x: CGFloat = 0
    var y: CGFloat = 0

    var angle = 0
    
    var scale = 1
    
    var elementView: Image
    
    init(x: CGFloat = 0, y: CGFloat = 0, angle: Int = 0, scale: Int = 1, elementView: Image) {
        self.x = x
        self.y = y
        self.angle = angle
        self.scale = scale
        self.elementView = elementView
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
